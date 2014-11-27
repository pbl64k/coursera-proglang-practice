## Sample solution for Guess The Word practice problem (section 7)

## Targets 1.9.3

require_relative './section-7-provided'

class ExtendedGuessTheWordGame < GuessTheWordGame
  ## YOUR CODE HERE

  # There's not much that we can (or want) to change here without changing the base class.
end

class ExtendedSecretWord < SecretWord
  ## YOUR CODE HERE

  def initialize word
    super word
    @lc_word = word.downcase
    self.pattern = ""
    self.word.each_char do |c|
      self.pattern += is_a_letter?(c) ? '-' : c
    end
    @guessed = ''
  end

  def valid_guess? guess
    g = guess.downcase
    super(g) && is_a_letter?(g) && !(@guessed.index g)
  end

  def guess_letter! letter
    found_dc = super(letter.downcase)
    found_uc = super(letter.upcase)
    @guessed += letter.downcase
    found_dc || found_uc
  end

  private

  def is_a_letter? letter
    letter =~ /[[:alpha:]]/
  end
end

## Change to `false` to run the original game
if true
  ExtendedGuessTheWordGame.new(ExtendedSecretWord).play
else
  GuessTheWordGame.new(SecretWord).play
end

