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
    let (:params)  {{original_text: 'Hello', translated_text: 'Hola',}}
    before(:each) do
      Card.new(params).save
      Card.new(params.merge(updated_at: '2019-11-19 13:22')).save
      Card.new(params.merge(updated_at: '2019-11-19 13:22')).save
    end

    it 'return cards some days ago' do
      expect(Card.days_ago.size).to eq(2)
    end
  end


  # it 'new action' do
  #   expect(create(:card)).to be_a Card
  # end

  describe 'new action' do
    subject(:card) { Card.new }
    it 'should_create_new_card' do
      expect(card).to be_a_new(Card)
    end
  end

end
