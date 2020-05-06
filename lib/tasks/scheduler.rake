# frozen_string_literal: true

task send_review_cards: :environment do
  puts 'Sending messages...'
  NotifyReviewCards.notify_review
  puts 'done.'
end
