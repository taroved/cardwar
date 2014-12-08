class TableController < ApplicationController
  def new
    @table = Table.create_random
    render :index
  end

  def index
    if @table = Table.where(id: params[:id], finished: false).first
      @history_turns = Turn.includes(:card_dealer, :card_user).
          where(table_id: @table.id).order(created_at: :desc).limit(10).offset(1).
          references(:card_dealer, :card_user)
      @turn = Turn.where(table_id: @table.id).order(created_at: :desc).first
    else
      redirect_to :controller => 'main'
    end
  end

  def turn
    if @table = Table.where(id: params[:id]).first

      if @table.finished?
        render :finish
      else
        @turn = @table.turn
        if @table.finished?
          render :finish
        else
          @history_turns = Turn.includes(:card_dealer, :card_user).
              where(table_id: @table.id).order(created_at: :desc).limit(10).offset(1).
              references(:card_dealer, :card_user)
          render :index
        end
      end

    else
      redirect_to :controller => 'main'
    end
  end
end
