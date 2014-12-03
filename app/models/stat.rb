class Stat
  def self.finished_games
    Table.where(finished: true).count
  end

  def self.current_games
    Table.where(finished: false).count
  end

  def self.winnner_dealer_games
    Table.where(finished: true, winner: Table::WINNER_DEALER).count
  end

  def self.winnner_user_games
    Table.where(finished: true, winner: Table::WINNER_USER).count
  end
end