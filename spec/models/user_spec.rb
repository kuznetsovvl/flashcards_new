# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation tests' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_confirmation_of(:password) }
  end

  describe 'mailer' do
    let!(:card) { create :card, updated_at: 10.seconds.ago }
    it 'send email about review' do
      User.notify_review
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
