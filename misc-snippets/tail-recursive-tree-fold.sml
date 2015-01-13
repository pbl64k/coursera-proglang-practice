(* Rather pointless tail-recursive tree traversal. *)
(* Note that you DON'T need this in SML. *)

datatype 'a tree = leaf | node of { value : 'a, left : 'a tree, right : 'a tree }

fun tree_foldl f acc t =
    let
        fun aux acc [] = acc
          | aux acc (leaf :: ts) = aux acc ts
          | aux acc (node { value = value, left = left, right = right } :: ts) =
                aux (f (acc, value)) (left :: right :: ts)
    in
        aux acc [t]
    end

val tree_sum = tree_foldl (op +) 0
    (node { value = 10, left = node { value = 5, left = leaf, right = leaf },
    right = node { value = 3, left = leaf, right = leaf }})

