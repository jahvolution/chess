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

  # Automatically initialize pieces when a game is created
  after_create :initialize_pieces

  private

  # Initialize all chess pieces for the game
  def initialize_pieces
    # Create Pawns
    (0..7).each do |i|
      pieces.create!(type: "Pawn", color: "white", position_x: i, position_y: 6) # White pawns on row 6
      pieces.create!(type: "Pawn", color: "black", position_x: i, position_y: 1) # Black pawns on row 1
    end

    # Create major pieces
    setup_major_pieces("white", 7) # White major pieces on row 7
    setup_major_pieces("black", 0) # Black major pieces on row 0
  end

  # Create major chess pieces (Rooks, Knights, etc.) for a given color and row
  def setup_major_pieces(color, row)
    pieces.create!(type: "Rook", color: color, position_x: 0, position_y: row)
    pieces.create!(type: "Knight", color: color, position_x: 1, position_y: row)
    pieces.create!(type: "Bishop", color: color, position_x: 2, position_y: row)
    pieces.create!(type: "Queen", color: color, position_x: 3, position_y: row)
    pieces.create!(type: "King", color: color, position_x: 4, position_y: row)
    pieces.create!(type: "Bishop", color: color, position_x: 5, position_y: row)
    pieces.create!(type: "Knight", color: color, position_x: 6, position_y: row)
    pieces.create!(type: "Rook", color: color, position_x: 7, position_y: row)
  end
end
