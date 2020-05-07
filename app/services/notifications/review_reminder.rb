# frozen_string_literal: true

module Notifications
  class ReviewReminder
    def call
      ReviewCards.new.find_user_for_review.each do |user|
        NotificationsMailer.pending_cards(user).deliver_now
      end
    end
  end
end
