class AddTypeToPieces < ActiveRecord::Migration[7.1]
  def change
    rename_column :pieces, :piece_type, :type
  end
end
