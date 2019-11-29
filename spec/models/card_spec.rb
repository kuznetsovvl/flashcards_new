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
    let (:params) { { original_text: 'Hello', translated_text: 'Hola' } }
    before(:each) do
      Card.new(params).save
      Card.new(params.merge(updated_at: '2019-11-19 13:22')).save
      Card.new(params.merge(updated_at: '2019-11-19 13:22')).save
    end

    it 'return cards some days ago' do
      expect(Card.days_ago.size).to_not be nil
    end
  end
end
