class Rook < Piece
  def symbol
    color == :white ? "♜" : "♖"
  end

  def valid_move?(end_pos, board, _skip_castling_check = false)
    start_row, start_col = @position
    end_row, end_col = end_pos

    # Must move in a straight line (same row or same column)
    return false unless start_row == end_row || start_col == end_col

    # Ensure no pieces are blocking the path
    path = path_between([start_row, start_col], [end_row, end_col], board)
    return false unless path.all?(&:nil?) # Path must be clear

    # Destination square must be empty or contain an opponent’s piece
    destination_piece = board[end_row][end_col]
    return true if destination_piece.nil? || destination_piece.color != color

    false
  end

  private

  def path_between(start_pos, end_pos, board)
    start_row, start_col = start_pos
    end_row, end_col = end_pos
    path = []

    if start_row == end_row # Moving horizontally
      range = start_col < end_col ? (start_col + 1...end_col) : (end_col + 1...start_col)
      range.each { |col| path << board[start_row][col] }
    else # Moving vertically
      range = start_row < end_row ? (start_row + 1...end_row) : (end_row + 1...start_row)
      range.each { |row| path << board[row][start_col] }
    end

    path
  end
end
