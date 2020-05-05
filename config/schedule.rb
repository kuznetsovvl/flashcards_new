# frozen_string_literal: true

every 1.day, at: '6:00 pm' do
  runner 'NotifyReviewCards.notify_review'
end
