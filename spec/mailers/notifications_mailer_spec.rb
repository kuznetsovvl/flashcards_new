# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationsMailer, type: :mailer do
  describe 'pending_cards' do
    let(:user) { create :user }
    let(:mail) { described_class.pending_cards(user).deliver_now }

    it 'renders the headers' do
      expect(mail.subject).to eq(I18n.t('mailer.pending_cards.subject'))
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([I18n.t('mailer.pending_cards.default')])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(user.email)
    end
  end
end
