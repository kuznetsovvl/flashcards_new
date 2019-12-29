# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'validation tests' do
    it { should validate_presence_of(:original_text) }
    it { should validate_presence_of(:translated_text) }
    it 'validate with valid original_text and translated_text' do
      expect(described_class.new(original_text: 'anything', translated_text: 'anything')).to_not be_valid
    end
  end

  describe 'scope test' do
    before do
      create(:user) do |user|
        user.cards.create(attributes_for(:card))
        user.cards.create(attributes_for(:card, updated_at: 4.days.ago))
        user.cards.create(attributes_for(:card, updated_at: 4.days.ago))
      end
    end

    it 'return cards some days ago' do
      expect(Card.days_ago.size).to eq(2)
    end
  end
end
