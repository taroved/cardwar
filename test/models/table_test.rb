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
    assert_not table.finished?, "User must not win in 25 turns"
  end

  test "dealer fast win" do
    table = tables(:dealer_luck)

    26.times.each {
      table.turn
    }
    assert (table.finished and table.winner == Table::WINNER_DEALER), "Dealer must win in 26 turns"
  end

  test "exception for turns on finished table" do
    table = tables(:user_luck)

    assert_raises(RuntimeError) {
      27.times.each {
        table.turn
      }
    }
  end

  test "ensure cards in stacks" do
    table = tables(:random)

    26.times.each {
      table.turn
      if (table.stack_user + table.stack_dealer + table.stack_turn).sort != (1..52).to_a
        assert false, "Cards are invalid"
      end
    }
    assert true
  end
end
