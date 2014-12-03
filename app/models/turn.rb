class Turn < ActiveRecord::Base
  belongs_to :table
  belongs_to :card_dealer, :class_name => 'Card'
  belongs_to :card_user, :class_name => 'Card'
end
