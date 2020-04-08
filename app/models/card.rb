# frozen_string_literal: true

class Card < ApplicationRecord
  belongs_to :deck

  scope :start_check, -> { where('status = 0') }
  scope :first_check, -> { where('status = 1 AND updated_at <= ?', 12.hours.ago) }
  scope :second_check, -> { where('status = 2 AND DATE(updated_at) <= ?', 3.days.ago.to_date) }
  scope :third_check, -> { where('status = 3 AND DATE(updated_at) <= ?', 7.days.ago.to_date) }
  scope :fourth_check, -> { where('status = 4 AND DATE(updated_at) <= ?', 2.weeks.ago.to_date) }
  scope :fifth_check, -> { where('status = 5 AND DATE(updated_at) <= ?', 1.month.ago.to_date) }

  validates :original_text, presence: true
  validates :translated_text, presence: true
  validate :compare

  has_attached_file :image, styles: { large: '600x600>', medium: '360x360>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 2.megabytes

  def compare
    if original_text&.downcase == translated_text&.downcase
      errors.add(:original_text, "Original text and translated text mustn't be equal")
    end
  end
end
