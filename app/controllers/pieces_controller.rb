class PiecesController < ApplicationController
  def legal_moves
    @game = Game.find(params[:game_id])
    @piece = @game.pieces.find(params[:id])
    @moves = @piece.legal_moves

    render json: @moves
  end

  def update
    @piece = Piece.find(params[:id])
    new_x = params[:x].to_i
    new_y = params[:y].to_i

    if @piece.legal_moves.include?([new_x, new_y])
      @piece.update_attributes(x: new_x, y: new_y)
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
end
