class ModifyGameTurnAndRemoveStatus < ActiveRecord::Migration[7.1]
  def change
    remove_column :games, :current_turn, :string
    remove_column :games, :status, :string
    add_column :games, :turn, :integer
  end
end
