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

  describe 'validation of images' do
    it { should have_attached_file(:image) }
    it { should validate_attachment_content_type(:image).allowing('image/jpg', 'image/jpeg', 'image/png', 'image/gif') }
    it { should validate_attachment_size(:image).less_than(2.megabytes) }
  end

  describe 'scope test' do
    before do
      create(:deck) do |deck|
        deck.cards.create(attributes_for(:card))
        deck.cards.create(attributes_for(:card, updated_at: 4.days.ago))
        deck.cards.create(attributes_for(:card, updated_at: 4.days.ago))
      end
    end

    it 'return cards some days ago' do
      expect(Card.days_ago.size).to eq(2)
    end
  end
end
