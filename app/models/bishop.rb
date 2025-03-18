class Bishop < Piece
  def symbol
    color == :white ? "♝" : "♗"
  end

  def valid_move?(end_pos, board)
    start_row, start_col = @position
    end_row, end_col = end_pos

    # Bishop moves diagonally, so the absolute row and column distance must be the same
    return false unless (start_row - end_row).abs == (start_col - end_col).abs

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

    row_step = end_row > start_row ? 1 : -1
    col_step = end_col > start_col ? 1 : -1

    current_row, current_col = start_row + row_step, start_col + col_step
    while current_row != end_row
      path << board[current_row][current_col]
      current_row += row_step
      current_col += col_step
    end

    path
  end
end
