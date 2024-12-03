class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :status
      t.string :current_turn

      t.timestamps
    end
  end
end
