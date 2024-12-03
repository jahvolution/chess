# == Schema Information
#
# Table name: games
#
#  id           :bigint           not null, primary key
#  current_turn :string
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Game < ApplicationRecord
end
