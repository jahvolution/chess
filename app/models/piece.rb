# == Schema Information
#
# Table name: pieces
#
#  id         :bigint           not null, primary key
#  color      :string
#  piece_type :string
#  position_x :integer
#  position_y :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :bigint           not null
#
# Indexes
#
#  index_pieces_on_game_id  (game_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#
class Piece < ApplicationRecord
  belongs_to :game

  def legal_moves
    case piece_type
    when "Pawn"
      legal_moves_for_pawn
    end
  end

  private

  def legal_moves_for_pawn

    # Define the direction the pawn moves based on its color
    direction = color == "white" ? -1 : 1
    moves = []

    # Move forward one square
    next_y = position_y + direction
    if game.pieces.none? { |p| p.position_x == position_x && p.position_y == next_y }
      moves << [position_x, next_y]
    end

    # Move forward two squares
    starting_rank = color == "white" ? 6 : 1
    if position_y == starting_rank &&
       game.pieces.none? { |p| p.position_x == position_x && p.position_y == next_y } &&
       game.pieces.none? { |p| p.position_x == position_x && p.position_y == next_y + direction }
      moves << [position_x, next_y + direction]
    end

    # Capture diagonally
    [-1, 1].each do |dx|
      next_x = position_x + dx
      next_y = position_y + direction
      piece = game.pieces.find { |p| p.position_x == next_x && p.position_y == next_y }
      if piece && piece.color != color
        moves << [next_x, next_y]
      end
    end

    moves = moves.select do |x, y|
      x >= 0 && x < 8 && y >= 0 && y < 8
    end
  end
end
