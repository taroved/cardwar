class Table < ActiveRecord::Base
  WINNER_DEALER = 0
  WINNER_USER = 1

  def stack_dealer=(stack_array)
    write_attribute(:stack_dealer, stack_array.join(','))
  end

  def stack_dealer
    read_attribute(:stack_dealer).split(',').map { |c| c.to_i }
  end

  def stack_user=(stack_array)
    write_attribute(:stack_user, stack_array.join(','))
  end

  def stack_user
    read_attribute(:stack_user).split(',').map { |c| c.to_i }
  end

  def stack_turn=(stack_array)
    write_attribute(:stack_turn, stack_array.join(','))
  end

  def stack_turn
    read_attribute(:stack_turn).split(',').map { |c| c.to_i }
  end

  def self.create_random
    t = self.new
    stack1, stack2 = Card.random_stacks()
    t.stack_dealer = stack1
    t.stack_user = stack2
    t.stack_turn = []
    t.save
    return t
  end

  def stack_dealer_size
    self.stack_dealer.size
  end

  def stack_user_size
    self.stack_user.size
  end

  def turn
    if self.new_record?
      raise "The table not saved"
    elsif self.finished?
      raise "The table is finished"
    end

    #get arrays
    dealer = self.stack_dealer
    user = self.stack_user
    turn = self.stack_turn

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
      self.winner = Table::WINNER_USER
      self.finished = true
    elsif user.empty?
      self.winner = Table::WINNER_DEALER
      self.finished = true
    end

    #save state
    self.stack_dealer = dealer
    self.stack_user = user
    self.stack_turn = turn
    self.save

    #save turn
    Turn.create(table: self, card_dealer_id: dealer_card, card_user_id: user_card)
  end
end
