class Piece
  attr_accessor :color, :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def symbol
    raise NotImplementedError, "Each piece must define its symbol"
  end

  def valid_move?(end_pos, board)
    raise NotImplementedError, "Each piece must implement move logic"
  end
end
