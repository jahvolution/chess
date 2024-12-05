class RenameTypeColumnInPieces < ActiveRecord::Migration[7.1]
  def change
    rename_column :pieces, :type, :piece_type
  end
end
