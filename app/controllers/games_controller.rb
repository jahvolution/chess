class GamesController < ApplicationController
  def chessboard
    @board = Array.new(8) { Array.new(8, nil) }

    @game = Game.first
    if @game
      @pieces = @game.pieces
      @pieces.each do |piece|
        @board[piece.position_y][piece.position_x] = "#{piece.color[0].upcase}#{piece.piece_type[0]}"
      end
    end
  end
end
