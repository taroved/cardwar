class Turn < ActiveRecord::Base
  belongs_to :table
  belongs_to :card_dealer, :class_name => 'Card'
  belongs_to :card_user, :class_name => 'Card'

  #todo: replace the quick code
  def get_history_class
    if self.card_dealer.rate < self.card_user.rate
      'history-win'
    elsif self.card_dealer.rate > self.card_user.rate
      'history-lose'
    else
      'history-draw'
    end
  end
end
