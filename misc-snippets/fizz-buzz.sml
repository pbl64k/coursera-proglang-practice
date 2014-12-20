(* FizzBuzz using lazy streams. *)

use "lazy-stream.sml";

val nats = Stream.unfold (fn x => SOME (x + 1, x)) 1
fun mkfn fact str (x, y) =
    if y mod fact = 0
    then x ^ str
    else x
val fs = Stream.fromList
    [fn (x, y) =>
        if x = ""
        then Int.toString y
        else x,
    mkfn 5 "Buzz",
    mkfn 3 "Fizz"]
val fizzbuzz_stream = Stream.map (fn n => Stream.fold (fn (f, facc) => f (facc (), n)) "" fs) nats
val fizzbuzz_100 = Stream.toList (Stream.take 100 fizzbuzz_stream);

print (List.foldl (fn (ns, acc) => acc ^ ns ^ "\n") "" fizzbuzz_100)

