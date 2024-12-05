module GamesHelper
  def piece_icon(piece)
    icons = {
      "Pawn"   => { "white" => "♙", "black" => "♟" },
      "Rook"   => { "white" => "♖", "black" => "♜" },
      "Knight" => { "white" => "♘", "black" => "♞" },
      "Bishop" => { "white" => "♗", "black" => "♝" },
      "Queen"  => { "white" => "♕", "black" => "♛" },
      "King"   => { "white" => "♔", "black" => "♚" }
    }
    icons[piece.piece_type][piece.color]
  end
end
