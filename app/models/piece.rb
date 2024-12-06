# == Schema Information
#
# Table name: pieces
#
#  id         :bigint           not null, primary key
#  color      :string
#  position_x :integer
#  position_y :integer
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :bigint           not null
#
# Indexes
#
#  index_pieces_on_game_id  (game_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#
class Piece < ApplicationRecord
  belongs_to :game

  def legal_moves
    raise NotImplementedError, "Subclasses must implement a legal_moves method"
  end
end
