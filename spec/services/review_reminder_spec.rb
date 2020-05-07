# frozen_string_literal: true

require 'rails_helper'

describe Notifications::ReviewReminder do
  let!(:card) { create(:card, updated_at: 10.seconds.ago) }
  it 'send email' do
    described_class.new.call
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
