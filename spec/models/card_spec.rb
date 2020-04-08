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

  describe 'scope test ' do
    before do
      create(:deck) do |deck|
        deck.cards.create(attributes_for(:card))
        deck.cards.create(attributes_for(:card))
        deck.cards.create(attributes_for(:card, updated_at: 13.hours.ago, status: 1))
        deck.cards.create(attributes_for(:card, updated_at: 4.days.ago, status: 2))
        deck.cards.create(attributes_for(:card, updated_at: 8.days.ago, status: 3))
        deck.cards.create(attributes_for(:card, updated_at: 3.weeks.ago, status: 4))
        deck.cards.create(attributes_for(:card, updated_at: 2.month.ago, status: 5))
      end
    end

    it 'return cards are esteblished immediately' do
      expect(Card.start_check.size).to eq(2)
    end
    it 'return cards after 12 hours' do
      expect(Card.first_check.size).to eq(1)
    end
    it 'return cards after 3 days' do
      expect(Card.second_check.size).to eq(1)
    end
    it 'return cards after 7 days' do
      expect(Card.third_check.size).to eq(1)
    end
    it 'return cards after 2 weeks' do
      expect(Card.fourth_check.size).to eq(1)
    end
    it 'return cards after 1 month' do
      expect(Card.fifth_check.size).to eq(1)
    end
  end
end
