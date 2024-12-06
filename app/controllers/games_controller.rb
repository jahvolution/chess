class GamesController < ApplicationController
  helper GamesHelper

  def start

  end

  def new
    Game.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('games')
    @game = Game.create
    redirect_to @game
  end

  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
    @board = Array.new(8) { Array.new(8) }
  end
end
