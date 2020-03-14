# frozen_string_literal: true

class AddDeckRefToCards < ActiveRecord::Migration[6.0]
  def change
    add_reference :cards, :deck, foreign_key: true
  end
end
