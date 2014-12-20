(* Toying with structures, signatures and functors. *)
(* An implementation of lazy values and streams. *)

(* A general signature for (wrapped) lazy values *)
signature LAZY = sig
    type 'a lazy
    val delay : (unit -> 'a) -> 'a lazy
    val force : 'a lazy -> 'a
end

(* Internally, lazy values are reference cells containing either a thunk or an already computed value *)
(* Any number of applications of force will never evaluate the thunk more than once *)
structure Lazy :> LAZY = struct
    datatype 'a lazycell = Thunk of unit -> 'a | Value of 'a
    type 'a lazy = ('a lazycell) ref
    fun delay f = ref (Thunk f)
    fun force x =
        case !x of
            Thunk f => (x := Value (f ()); force x)
          | Value x => x            
end

(* A general signature for possibly lazy, possibly infinite streams *)
signature STREAM = sig
    exception EmptyStream
    type 'a stream
    val empty : 'a stream
    (* Streams as described by this signature are necessarily strict in their head *)
    val #:: : 'a * (unit -> 'a stream) -> 'a stream
    val singleton : 'a -> 'a stream
    val isEmpty : 'a stream -> bool
    (* `uncons` should not evaluate the tail, leaving that to the client *)
    val uncons : 'a stream -> 'a * (unit -> 'a stream)
    val head : 'a stream -> 'a
    val tail : 'a stream -> 'a stream
    (* This signature might be surprising, but it allows the client to decide whether the folding should continue *)
    val fold : ('a * (unit -> 'b) -> 'b) -> 'b -> 'a stream -> 'b
    val unfold : ('a -> ('a * 'b) option) -> 'a -> 'b stream
    val map : ('a -> 'b) -> 'a stream -> 'b stream
    val filter : ('a -> bool) -> 'a stream -> 'a stream
    val all : ('a -> bool) -> 'a stream -> bool
    val exists : ('a -> bool) -> 'a stream -> bool
    val concat : ('a stream) stream -> 'a stream
    val flatMap : ('a -> 'b stream) -> 'a stream -> 'b stream
    val zip : 'a stream * 'b stream -> ('a * 'b) stream
    val unzip : ('a * 'b) stream -> 'a stream * 'b stream
    val repeat : 'a -> 'a stream
    val cycle : 'a stream -> 'a stream
    val take : int -> 'a stream -> 'a stream
    val drop : int -> 'a stream -> 'a stream
    val toList : 'a stream -> 'a list
    val fromList : 'a list -> 'a stream
end

(* Some parts of behavior might be surprising if you're coming from properly lazy background. *)
(* The stream is lazy in its tail, but not in its head. Some functions (`zip` in particular) *)
(* may evaluate more than is strictly needed. *)
(* The approach tries to strike a sensible balance between convenient semantics and convenient *)
(* notation -- potentially failing at both. *)
functor LazyStream (structure L : LAZY) :> STREAM = struct
    exception EmptyStream
    datatype 'a stream = Nil | Cons of 'a * (('a stream) L.lazy)
    val empty = Nil
    infix #::
    fun x #:: xs = Cons (x, L.delay xs)
    fun singleton x = x #:: (fn () => empty)
    fun isEmpty Nil = true
      | isEmpty _ = false
    fun uncons (Cons (x, xs)) = (x, fn () => L.force xs)
      | uncons _ = raise EmptyStream
    fun head (Cons (x, _)) = x
      | head _ = raise EmptyStream
    fun tail xs = (#2 (uncons xs)) ()
    (* This particular version of `fold` allows `all` and `exists` to be expressed in its terms, *)
    (* while preserving the property of terminating as soon as the answer is known for certain. *)
    fun fold _ z Nil = z
      | fold f z (Cons (x, xs)) = f (x, fn () => fold f z (L.force xs))
    fun unfold f z =
        let
            val x = f z
        in
            case x of
                NONE => empty
              | SOME (z', x) => x #:: (fn () => unfold f z')
        end
    fun map_unfolder f fxs =
        let
            val xs = fxs ()
        in
            if isEmpty xs
            then NONE
            else
                let
                    val (x, fxs') = uncons xs
                in
                    SOME (fxs', f x)
                end
        end
    fun map f xs = unfold (map_unfolder f) (fn () => xs)
    fun filter_unfolder p fxs =
        let
            val xs = fxs ()
        in
            if isEmpty xs
            then NONE
            else
                let
                    val (x, fxs') = uncons xs
                in
                    if p x
                    then SOME (fxs', x)
                    else filter_unfolder p fxs'
                end
        end
    fun filter p xs = unfold (filter_unfolder p) (fn () => xs)
    fun concat_unfolder fxss =
        let
            val xss = fxss ()
        in
            if isEmpty xss
            then NONE
            else
                let
                    val (xs, fxss') = uncons xss
                in
                    if isEmpty xs
                    then concat_unfolder fxss'
                    else
                        let
                            val (x, fxs') = uncons xs
                        in
                            SOME (fn () => fxs' () #:: fxss', x)
                        end
                end
        end
    fun concat xss = unfold concat_unfolder (fn () => xss)
    fun all p xs = fold (fn (x, facc) => p x andalso facc ()) true xs
    fun exists p xs = not (all (fn x => not (p x)) xs)
    fun flatMap f xs = concat (map f xs)
    fun zip_unfolder fxys =
        let
            val (xs, ys) = fxys ()
        in
            if isEmpty xs orelse isEmpty ys
            then NONE
            else
                let
                    val (x, fxs') = uncons xs
                    val (y, fys') = uncons ys
                in
                    SOME (fn () => (fxs' (), fys' ()), (x, y))
                end
        end
    fun zip (xs, ys) = unfold zip_unfolder (fn () => (xs, ys))
    fun unzip_folder ((x, y) : 'a * 'b, fxys : unit -> 'a stream * 'b stream) =
        let
            val accp = L.delay fxys
        in
            (x #:: (fn () => #1 (L.force accp)), y #:: (fn () => #2 (L.force accp)))
        end
    fun unzip xs =
        let
        in
            fold unzip_folder (empty, empty) xs
        end
    fun cycle_unfolder init fxs =
        let
            val xs = fxs ()
        in
            if isEmpty xs
            then cycle_unfolder init (fn () => init)
            else
                let
                    val (x, fxs') = uncons xs
                in
                    SOME (fxs', x)
                end
        end
    (* Note that this simply doesn't terminate if applied to an empty stream. *)
    fun cycle xs = unfold (cycle_unfolder xs) (fn () => xs)
    fun repeat xs = (cycle o singleton) xs
    fun take_unfolder (n, fxs) =
        if n = 0
        then NONE
        else
            let
                val xs = fxs ()
            in
                if isEmpty xs
                then NONE
                else
                    let
                        val (x, fxs') = uncons xs
                    in
                        SOME ((n - 1, fxs'), x)
                    end
            end
    fun take n xs = unfold take_unfolder (n, fn () => xs)
    fun drop 0 xs = xs
      | drop n xs = drop (n - 1) (tail xs)
    fun toList xs = fold (fn (x, facc) => x :: facc ()) [] xs
    fun fromList xs =
        let
            fun f [] = NONE
              | f (x :: xs) = SOME (xs, x)
        in
            unfold f xs
        end
end

structure Stream = LazyStream (structure L = Lazy)

