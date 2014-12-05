# Practice Problems for Section 7

## Guess The Word

We'll toy a bit with a simple word guessing game (known under
the rather morbid name of "Hangman"). Our implementation has a
simple text-based interface, and doesn't aim to be fully
playable -- it doesn't make much effort to hide the secret
word or phrase from the player, for example.

Save the provided code implementing a particularly half-baked
version of the game in a file named `section-7-provided.rb`,
put the template solution file nearby, inspect the code, run
the game and play a little. Use the template solution file
to implement the changes described below. Note that you
should only change the template file.

### Ignore Punctuation

The first player may enter a phrase or sentence instead of a
single word. The current implementation doesn't treat spaces
or punctuation marks in any special way. Change the game so
that punctuation marks and spaces are not hidden from the
second player. You should also reject non-letter characters
as guesses.

### Case Insensitivity

The game currently treats lowercase and uppercase letters as
being different. Change that so that entering either a
lowercase or an uppercase letter as a guess would uncover all
the corresponding letters in the secret word or phrase,
regardless of their case.

**NOTE:** You shouldn't just convert both the secret word and
the guesses to lower or upper case -- that's not neat.

### Forgive Repeated Guesses

Player may try to guess the same letter (whether present or
absent from the secret phrase) multiple times. The current
implementation will reduce the number of remaining attempts
for all incorrect attempts, even repeated ones, and will not
not mind the repeated correct guesses. Change the game so that
repeated guesses are rejected as invalid instead.

**EXAMPLE:** After implementing all the changes described
above, a sample game session could look as follows:

    Welcome to Guess The Word!
    Enter the secret word of phrase:
    Alas, poor Yorick!
    Secret word:
    ----, ---- ------!
    9 incorrect guess(es) left.
    Enter the letter you want uncovered:
    A
    Secret word:
    A-a-, ---- ------!
    9 incorrect guess(es) left.
    Enter the letter you want uncovered:
    y
    Secret word:
    A-a-, ---- Y-----!
    9 incorrect guess(es) left.
    Enter the letter you want uncovered:
    a
    I'm sorry, but that's not a valid letter.
    Secret word:
    A-a-, ---- Y-----!
    9 incorrect guess(es) left.
    Enter the letter you want uncovered:
    ,
    I'm sorry, but that's not a valid letter.
    Secret word:
    A-a-, ---- Y-----!
    9 incorrect guess(es) left.

etc.
