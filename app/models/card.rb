class Card < ActiveRecord::Base
  RATES = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  SUITES = [0, 1, 2, 3]


  def self.random_stacks
    Array.new(52) {|index| index+1}.shuffle.each_slice(52/2).to_a
  end

  def self.get_rate_by_id(id)
    (id - 1) % Card::RATES.size
  end

  def self.get_suit_by_id(id)
    (id - 1) / Card::RATES.size
  end

  def get_card_class
    'card-%s-%s' % [(self.rate+1) % Card::RATES.size, self.suit]
  end
end
