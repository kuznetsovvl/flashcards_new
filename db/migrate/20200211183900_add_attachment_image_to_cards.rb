# frozen_string_literal: true

class AddAttachmentImageToCards < ActiveRecord::Migration[6.0]
  def self.up
    change_table :cards do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :cards, :image
  end
end
