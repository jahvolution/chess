class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
    setup_pieces
  end

  def setup_pieces
    # Set up pawns
    (0..7).each do |i|
      @grid[1][i] = Pawn.new(:black, [1, i])
      @grid[6][i] = Pawn.new(:white, [6, i])
    end

    # Set up other pieces (rooks, knights, bishops, queen, king)
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    back_row.each_with_index do |piece, i|
      @grid[0][i] = piece.new(:black, [0, i])
      @grid[7][i] = piece.new(:white, [7, i])
    end
  end

  def display
    puts "  a b c d e f g h"
    @grid.each_with_index do |row, i|
      print "#{8 - i} "
      row.each do |cell|
        print cell.nil? ? "· " : "#{cell.symbol} "
      end
      puts "#{8 - i}"
    end
    puts "  a b c d e f g h"
  end

  def move_piece(start_pos, end_pos)
    piece = @grid[start_pos[0]][start_pos[1]]

    if piece.nil?
      puts "No piece at #{start_pos}. Try again."
      return false
    end

    if piece.valid_move?(end_pos, @grid)
      @grid[end_pos[0]][end_pos[1]] = piece
      @grid[start_pos[0]][start_pos[1]] = nil
      piece.position = end_pos
      puts "Moved #{piece.class} to #{end_pos}"
      return true
    else
      puts "Invalid move for #{piece.class}. Try again."
      return false
    end
  end
end
