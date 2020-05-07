# frozen_string_literal: true

task send_review_cards: :environment do
  puts 'Sending messages...'
  Notifications::ReviewReminder.new.call
  puts 'done.'
end
