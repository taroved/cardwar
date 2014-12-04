require 'test_helper'

class CardTest < ActiveSupport::TestCase
  test "shuffle stacks" do
    stacks = Card.random_stacks
    assert (1..52).to_a == stacks.flatten.sort, 'Card shuffle stacks failed'
  end
end
