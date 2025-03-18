class King < Piece
  attr_accessor :moved

  def initialize(color, position)
    super(color, position)
    @moved = false
  end

  def symbol
    color == :white ? "♚" : "♔"
  end

  def valid_move?(end_pos, board)
    start_row, start_col = @position
    end_row, end_col = end_pos

    # Allow castling if conditions are met
    return true if castling?(end_pos, board)

    row_diff = (start_row - end_row).abs
    col_diff = (start_col - end_col).abs

    return false unless row_diff <= 1 && col_diff <= 1

    destination_piece = board[end_row][end_col]
    return false if destination_piece && destination_piece.color == color

    return false if move_into_check?(end_pos, board)

    true
  end

  def move(end_pos)
    @moved = true
    @position = end_pos
  end

  def castling?(end_pos, board)
    return false if moved || in_check?(board)

    start_row, start_col = @position
    end_row, end_col = end_pos

    # Castling only occurs on the same row
    return false unless start_row == end_row

    # Short castling (kingside)
    if end_col == start_col + 2
      return can_castle?(board, start_row, start_col, start_col + 3)
    end

    # Long castling (queenside)
    if end_col == start_col - 2
      return can_castle?(board, start_row, start_col, start_col - 4)
    end

    false
  end

  def checkmate?(board)
    return false unless in_check?(board) # King must be in check first

    # Check if the King has any valid moves
    return false if possible_king_moves(board).any? { |move| !move_into_check?(move, board) }

    # Check if any allied piece can block or capture the attacking piece
    return false if can_escape_check?(board)

    true
  end

  def possible_king_moves(board)
    row, col = @position
    moves = []

    (-1..1).each do |r_diff|
      (-1..1).each do |c_diff|
        next if r_diff == 0 && c_diff == 0
        new_pos = [row + r_diff, col + c_diff]
        moves << new_pos if new_pos.all? { |coord| coord.between?(0, 7) }
      end
    end

    moves
  end

  private

  def in_check?(board)
    opponent_pieces = board.grid.flatten.compact.select { |piece| piece.color != color }

    opponent_pieces.any? do |piece|
      if piece.is_a?(King)
        piece.possible_king_moves(board).include?(@position)
      else
        piece.valid_move?(@position, board)
      end
    end
  end

  def can_escape_check?(board)
    allied_pieces = board.grid.flatten.compact.select { |piece| piece.color == color && piece != self }

    allied_pieces.any? do |piece|
      piece_moves = piece.possible_moves(board)
      piece_moves.any? do |move|
        temp_board = Marshal.load(Marshal.dump(board))
        temp_board[piece.position[0]][piece.position[1]] = nil
        temp_board[move[0]][move[1]] = piece
        !in_check?(temp_board)
      end
    end
  end

  def can_castle?(board, row, king_col, rook_col)
    rook = board[row][rook_col]
    return false unless rook.is_a?(Rook) && !rook.moved

    # Ensure there are no pieces between the King and the Rook
    col_range = rook_col > king_col ? (king_col + 1...rook_col) : (rook_col + 1...king_col)
    return false unless col_range.all? { |col| board[row][col].nil? }

    # Ensure the King doesn't pass through or end up in check
    return false if col_range.any? { |col| move_into_check?([row, col], board) }

    true
  end
end
