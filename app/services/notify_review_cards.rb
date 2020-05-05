# frozen_string_literal: true

class NotifyReviewCards
  def self.notify_review
    ReviewCards.new.find_user_for_review.each do |user|
      NotificationsMailer.pending_cards(user).deliver_now
    end
  end
end
