class Pawn < Piece
  attr_accessor :moved

  def initialize(color, position)
    super(color, position)
    @moved = false
  end

  def symbol
    color == :white ? "♟" : "♙"
  end

  def valid_move?(end_pos, board, last_move = nil)
    start_row, start_col = @position
    end_row, end_col = end_pos
    direction = color == :white ? -1 : 1

    # Normal one-step forward
    if end_col == start_col && end_row == start_row + direction && board.grid[end_row][end_col].nil?
      return true
    end

    # Two-square move on first move
    if !@moved && end_col == start_col && end_row == start_row + (2 * direction) &&
       board.grid[start_row + direction][end_col].nil? && board.grid[end_row][end_col].nil?
      return true
    end

    # Capture move (diagonal)
    if (end_col - start_col).abs == 1 && end_row == start_row + direction
      return !board.grid[end_row][end_col].nil? && board.grid[end_row][end_col].color != color
    end

    # En Passant
    if last_move && last_move[:piece].is_a?(Pawn) &&
       (last_move[:start_pos][0] - last_move[:end_pos][0]).abs == 2 && # Enemy pawn moved 2 squares
       last_move[:end_pos][0] == start_row && # Same row
       (last_move[:end_pos][1] - start_col).abs == 1 && # Next to the pawn
       end_row == start_row + direction && end_col == last_move[:end_pos][1] # Move diagonally into empty space

      return true
    end

    false
  end

  def move(end_pos)
    @moved = true
    @position = end_pos
  end
end
