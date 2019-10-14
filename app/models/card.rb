class Card < ApplicationRecord
  validates :original_text, presence: true
  validates :translated_text, presence: true
end
