class Pawn < Piece
  def legal_moves
    direction = color == "white" ? -1 : 1
    puts "Direction: #{direction}" # Debugging direction

    moves = []

    # Move forward one square
    next_y = position_y + direction
    puts "Next Y: #{next_y}"
    puts "Is square (#{position_x}, #{next_y}) empty? #{game.pieces.none? { |p| p.position_x == position_x && p.position_y == next_y }}"
    if game.pieces.none? { |p| p.position_x == position_x && p.position_y == next_y }
      moves << [position_x, next_y]
    end

    # Move forward two squares if on starting rank
    starting_rank = color == "white" ? 6 : 1
    if position_y == starting_rank &&
       game.pieces.none? { |p| p.position_x == position_x && p.position_y == position_y + direction } &&
       game.pieces.none? { |p| p.position_x == position_x && p.position_y == position_y + (2 * direction) }
      moves << [position_x, position_y + (2 * direction)]
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

    # Filter out-of-bounds moves
    moves = moves.select { |x, y| x.between?(0, 7) && y.between?(0, 7) }
    puts "Legal moves for Pawn #{id} at (#{position_x}, #{position_y}): #{moves.inspect}" # Output all moves
    moves
  end
end
