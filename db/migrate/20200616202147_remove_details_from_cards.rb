class RemoveDetailsFromCards < ActiveRecord::Migration[6.0]
  def change
    remove_column :cards, :status, :integer
    remove_column :cards, :mistake_counter, :integer
  end
end
