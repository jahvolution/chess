class PiecesController < ApplicationController
  def legal_moves
    @game = Game.find(params[:game_id])
    @piece = @game.pieces.find(params[:id])
    @moves = @piece.legal_moves

    render json: @moves
  end
end
