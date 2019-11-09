class Card < ApplicationRecord
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validate :compare
  def compare
    if original_text.downcase == translated_text.downcase
    errors.add(:original_text, "Original text and translated text mustn't be equal")
    end
  end
end
