## Note that this test doesn't verify your solution in any way except for checking
## that the final outcomes are correct.

require "minitest/autorun"

## You may need to change the path to your solution.
require_relative "./section-8-solution"

class TestAdventure < MiniTest::Unit::TestCase
  def setup
    @sir_foldalot = Knight.new(15, 3)
    @knight_of_lambda_calculus = Knight.new(10, 10)
    @sir_pinin_for_the_fjords = Knight.new(0, 15)
    @alonzo_the_wise = Wizard.new(3, 50)
    @dhuwe_the_unready = Wizard.new(8, 5)

    @dungeon_of_mupl = [Monster.new(1, 1),
      FloorTrap.new(3),
      Monster.new(5, 3),
      Potion.new(5, 5),
      Monster.new(1, 15),
      Armor.new(10),
      FloorTrap.new(5),
      Monster.new(10, 10)]
    @the_dark_castle_of_proglang = [Potion.new(3, 3),
      Monster.new(1, 1),
      Monster.new(2, 2),
      Monster.new(4, 4),
      FloorTrap.new(3),
      Potion.new(3, 3),
      Monster.new(4, 4),
      Monster.new(8, 8),
      Armor.new(5),
      Monster.new(3, 5),
      Monster.new(6, 6),
      FloorTrap.new(5)]
  end

  def test_overall_game_logic
    outcome_1 = Adventure.new(Null.new, @sir_foldalot.dup, @dungeon_of_mupl).play_out
    assert_equal "HP: 8 AP: 0", outcome_1.to_s

    outcome_2 = Adventure.new(Null.new, @knight_of_lambda_calculus.dup, @dungeon_of_mupl).play_out
    assert_equal "HP: 10 AP: 0", outcome_2.to_s

    outcome_3 = Adventure.new(Null.new, @sir_pinin_for_the_fjords.dup, @dungeon_of_mupl).play_out
    assert_equal "HP: 0 AP: 15", outcome_3.to_s

    outcome_4 = Adventure.new(Null.new, @alonzo_the_wise.dup, @dungeon_of_mupl).play_out
    assert_equal "HP: 8 MP: 24", outcome_4.to_s

    outcome_5 = Adventure.new(Null.new, @dhuwe_the_unready.dup, @dungeon_of_mupl).play_out
    assert_equal "HP: 13 MP: -10", outcome_5.to_s

    outcome_6 = Adventure.new(Null.new, @sir_foldalot.dup, @the_dark_castle_of_proglang).play_out
    assert_equal "HP: -2 AP: 0", outcome_6.to_s

    outcome_7 = Adventure.new(Null.new, @knight_of_lambda_calculus.dup, @the_dark_castle_of_proglang).play_out
    assert_equal "HP: 0 AP: 0", outcome_7.to_s

    outcome_8 = Adventure.new(Null.new, @sir_pinin_for_the_fjords.dup, @the_dark_castle_of_proglang).play_out
    assert_equal "HP: 0 AP: 15", outcome_8.to_s

    outcome_9 = Adventure.new(Null.new, @alonzo_the_wise.dup, @the_dark_castle_of_proglang).play_out
    assert_equal "HP: 9 MP: 24", outcome_9.to_s

    outcome_10 = Adventure.new(Null.new, @dhuwe_the_unready.dup, @the_dark_castle_of_proglang).play_out
    assert_equal "HP: 14 MP: -1", outcome_10.to_s
  end
end

