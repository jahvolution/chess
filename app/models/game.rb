# == Schema Information
#
# Table name: games
#
#  id         :bigint           not null, primary key
#  turn       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Game < ApplicationRecord
  has_many :pieces, dependent: :destroy

  after_create :initialize_pieces

  def initialize_pieces
    # Create Pawns
    (0..7).each do |i|
      pieces.create(piece_type: "Pawn", color: "white", position_x: i, position_y: 1)
      pieces.create(piece_type: "Pawn", color: "black", position_x: i, position_y: 6)
    end

    # Create other pieces for White
    setup_major_pieces("white", 0)

    # Create other pieces for Black
    setup_major_pieces("black", 7)
  end

  def setup_major_pieces(color, row)
    pieces.create(piece_type: "Rook", color: color, position_x: 0, position_y: row)
    pieces.create(piece_type: "Knight", color: color, position_x: 1, position_y: row)
    pieces.create(piece_type: "Bishop", color: color, position_x: 2, position_y: row)
    pieces.create(piece_type: "Queen", color: color, position_x: 3, position_y: row)
    pieces.create(piece_type: "King", color: color, position_x: 4, position_y: row)
    pieces.create(piece_type: "Bishop", color: color, position_x: 5, position_y: row)
    pieces.create(piece_type: "Knight", color: color, position_x: 6, position_y: row)
    pieces.create(piece_type: "Rook", color: color, position_x: 7, position_y: row)
  end
end
