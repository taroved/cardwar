class TableController < ApplicationController
  def new
    @table = Table.create_random
    render :index
  end

  def index
    if @table = Table.where(id: params[:id], finished: 0).first
      @history_turns = Turn.where(table_id: @table.id).order(created_at: :desc).limit(10).offset(1)
      @turn = Turn.where(table_id: @table.id).order(created_at: :desc).first
    else
      redirect_to :controller => 'main'
    end
  end

  def turn
    @table = Table.find(params[:id])
    @turn = @table.turn
    @history_turns = Turn.where(table_id: @table.id).order(created_at: :desc).limit(10).offset(1)
    if @table.finished?
      render :finish
    else
      render :index
    end

  end
end
