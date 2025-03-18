class Queen < Piece
  def symbol
    color == :white ? "♛" : "♕"
  end

  def valid_move?(end_pos, board)
    start_row, start_col = @position
    end_row, end_col = end_pos

    # Queen moves like a Rook (straight lines) or a Bishop (diagonal)
    if start_row == end_row || start_col == end_col
      # Rook-style movement
      path = path_between([start_row, start_col], [end_row, end_col], board, :straight)
    elsif (start_row - end_row).abs == (start_col - end_col).abs
      # Bishop-style movement
      path = path_between([start_row, start_col], [end_row, end_col], board, :diagonal)
    else
      return false
    end

    return false unless path.all?(&:nil?) # Path must be clear

    # Destination square must be empty or contain an opponent’s piece
    destination_piece = board[end_row][end_col]
    return true if destination_piece.nil? || destination_piece.color != color

    false
  end

  private

  def path_between(start_pos, end_pos, board, mode)
    start_row, start_col = start_pos
    end_row, end_col = end_pos
    path = []

    if mode == :straight
      if start_row == end_row
        range = start_col < end_col ? (start_col + 1...end_col) : (end_col + 1...start_col)
        range.each { |col| path << board[start_row][col] }
      else
        range = start_row < end_row ? (start_row + 1...end_row) : (end_row + 1...start_row)
        range.each { |row| path << board[row][start_col] }
      end
    elsif mode == :diagonal
      row_step = end_row > start_row ? 1 : -1
      col_step = end_col > start_col ? 1 : -1

      current_row, current_col = start_row + row_step, start_col + col_step
      while current_row != end_row
        path << board[current_row][current_col]
        current_row += row_step
        current_col += col_step
      end
    end

    path
  end
end
