class CreatePieces < ActiveRecord::Migration[7.1]
  def change
    create_table :pieces do |t|
      t.string :type
      t.integer :position_x
      t.integer :position_y
      t.string :color
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
