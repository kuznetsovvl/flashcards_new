# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :decks, dependent: :destroy

  validates :password, confirmation: true, presence: true
  validates :email, presence: true, uniqueness: true

  def self.notify_review
    ReviewCards.new.find_user_for_review.each do |user|
      NotificationsMailer.pending_cards(user).deliver_now
    end
  end
end
