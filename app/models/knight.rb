class Knight < Piece
  def symbol
    color == :white ? "♞": "♘"
  end

  def valid_move?(end_pos, board)
    start_row, start_col = @position
    end_row, end_col = end_pos

    # Knight moves in an "L" shape: two squares in one direction and one in another
    row_diff = (start_row - end_row).abs
    col_diff = (start_col - end_col).abs

    return false unless (row_diff == 2 && col_diff == 1) || (row_diff == 1 && col_diff == 2)

    # Destination square must be empty or contain an opponent’s piece
    destination_piece = board[end_row][end_col]
    return true if destination_piece.nil? || destination_piece.color != color

    false
  end
end
