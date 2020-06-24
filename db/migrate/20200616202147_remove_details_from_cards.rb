# frozen_string_literal: true

class RemoveDetailsFromCards < ActiveRecord::Migration[6.0]
  def change
    remove_column :cards, :status, :integer
  end
end
