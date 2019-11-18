# frozen_string_literal: true

class Card < ApplicationRecord
  scope :days_ago, -> { where('DATE(updated_at) >= ?', 3.days.ago.to_date) }
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validate :compare

  def compare
    if original_text&.downcase == translated_text&.downcase
      errors.add(:original_text, "Original text and translated text mustn't be equal")
    end
  end
end
