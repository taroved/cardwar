class Table < ActiveRecord::Base
  WINNER_DEALER = 0
  WINNER_USER = 1

  def self.create_random
    t = self.new
    stack1, stack2 = Card.random_stacks()
    t.stack_dealer = stack1.join(',')
    t.stack_user = stack2.join(',')
    t.stack_turn = [].join(',')
    t.save
    return t
  end

  def stack_dealer_size
    self.stack_dealer.split(',').size
  end

  def stack_user_size
    self.stack_user.split(',').size
  end

  def turn
    if self.new_record?
      raise "The table not saved"
    elsif self.finished?
      raise "The table is finished"
    end

    #strings to arrays
    dealer = self.stack_dealer.split(',').map { |c| c.to_i }
    user = self.stack_user.split(',').map { |c| c.to_i }
    turn = self.stack_turn.split(',').map { |c| c.to_i }

    dealer_card = dealer.shift
    user_card = user.shift

    #turn
    turn.push(dealer_card, user_card)
    if Card.get_rate_by_id(dealer_card) > Card.get_rate_by_id(user_card)
      dealer += turn
      turn = []
    elsif Card.get_rate_by_id(dealer_card) < Card.get_rate_by_id(user_card)
      user += turn
      turn = []
    end

    #check winner
    if dealer.empty?
      self.winner = self::WINNER_USER
      self.finished = true
    elsif user.empty?
      self.winner = self::WINNER_DEALER
      self.finished = true
    end

    #save state
    self.stack_dealer = dealer.join(',')
    self.stack_user = user.join(',')
    self.stack_turn = turn.join(',')
    self.save

    #save turn
    Turn.create(table: self, card_dealer: Card.find(dealer_card), card_user: Card.find(user_card))
  end
end
