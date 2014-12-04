require 'test_helper'

class TableTest < ActiveSupport::TestCase
  test "user fast win" do
    table = tables(:user_luck)

    26.times.each {
      table.turn
    }
    assert (table.finished and table.winner == Table::WINNER_USER), "User must win in 26 turns"
  end

  test "user not win in 25 turns" do
    table = tables(:user_luck)

    25.times.each {
      table.turn
    }
    assert !table.finished?, "User must not win in 25 turns"
  end
end
