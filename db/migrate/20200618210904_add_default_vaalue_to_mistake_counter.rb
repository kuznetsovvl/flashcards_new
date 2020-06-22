# frozen_string_literal: true

class AddDefaultVaalueToMistakeCounter < ActiveRecord::Migration[6.0]
  def change
    change_column :cards, :mistake_counter, :integer, default: 0
  end
end
