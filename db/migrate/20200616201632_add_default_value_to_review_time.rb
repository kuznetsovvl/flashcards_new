# frozen_string_literal: true

class AddDefaultValueToReviewTime < ActiveRecord::Migration[6.0]
  def change
    change_column :cards, :review_time, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
