module GamesHelper
  def piece_icon(piece)
    image_path = "chess_pieces/#{piece.color}_#{piece.type.downcase}.svg"
    image_tag(image_path, alt: piece.type, class: 'chess-piece')
  end
end
