# frozen_string_literal: true

class AddDeckRefToCards < ActiveRecord::Migration[6.0]
  def change
    add_reference :cards, :deck, foreign_key: true
    add_reference :decks, :user, foreign_key: true
    remove_reference :cards, :user, null: false, foreign_key: true
  end
end
