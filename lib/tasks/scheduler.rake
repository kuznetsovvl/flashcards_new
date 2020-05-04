# frozen_string_literal: true

task pending_cards: :environment do
  puts 'Sending messages...'
  User.notify_review
  puts 'done.'
end
