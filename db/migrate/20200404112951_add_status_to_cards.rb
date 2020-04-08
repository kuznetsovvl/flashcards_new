# frozen_string_literal: true

class AddStatusToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :status, :integer, default: 0
    add_column :cards, :mistake_counter, :integer, default: 0
  end
end
