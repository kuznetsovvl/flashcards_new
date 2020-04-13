# frozen_string_literal: true

class AddUserToCards < ActiveRecord::Migration[6.0]
  def change
    add_reference :cards, :user, foreign_key: true
  end
end
