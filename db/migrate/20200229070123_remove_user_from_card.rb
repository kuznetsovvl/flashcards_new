# frozen_string_literal: true

class RemoveUserFromCard < ActiveRecord::Migration[6.0]
  def change
    remove_reference :cards, :user, null: false, foreign_key: true
  end
end
