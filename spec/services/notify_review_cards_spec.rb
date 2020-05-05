# frozen_string_literal: true

require 'rails_helper'

describe NotifyReviewCards do
  context 'mailer' do
    let!(:card) { create :card, updated_at: 10.seconds.ago }
    it 'send email about review' do
      described_class.notify_review
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
