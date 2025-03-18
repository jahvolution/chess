class Game
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @current_player = :white
  end

  def play
    puts "Welcome to Chess! White moves first."
    board.display

    until game_over?
      take_turn
    end

    puts "Game over! #{winner_message}"
  end

  private

  def take_turn
    puts "#{current_player.to_s.capitalize}'s turn. Enter move (e.g., 'e2 e4'):"
    input = gets.chomp.downcase
    start_pos, end_pos = parse_input(input)

    if valid_move?(start_pos, end_pos)
      piece = board.grid[start_pos[0]][start_pos[1]]
      piece.move(end_pos)
      board.grid[end_pos[0]][end_pos[1]] = piece
      board.grid[start_pos[0]][start_pos[1]] = nil
      switch_player
      board.display
    else
      puts "Invalid move. Try again."
    end
  end

  def parse_input(input)
    coordinates = input.split.map do |pos|
      next unless pos.match?(/^[a-h][1-8]$/) # Ensure input is in correct format
      [8 - pos[1].to_i, pos[0].ord - 'a'.ord]
    end

    if coordinates.compact.size == 2
      return coordinates
    else
      puts "Invalid input format. Please use the format 'e2 e4'."
      return take_turn
    end
  end

  def valid_move?(start_pos, end_pos)
    piece = board.grid[start_pos[0]][start_pos[1]]

    if piece.nil?
      puts "No piece at the selected position. Try again."
      return false
    end

    unless piece.color == current_player
      puts "You can only move your own pieces. Try again."
      return false
    end

    piece.valid_move?(end_pos, board)
  end

  def switch_player
    @current_player = @current_player == :white ? :black : :white
  end

  def game_over?
    king = board.grid.flatten.compact.find { |piece| piece.is_a?(King) && piece.color == current_player }
    king&.checkmate?(board) || false
  end

  def winner_message
    current_player == :white ? "Black wins!" : "White wins!"
  end
end
