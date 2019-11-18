# frozen_string_literal: true

require 'rails_helper'
	
RSpec.describe Card, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:original_text) }
  end

  describe 'validations' do
    it { should validate_presence_of(:translated_text) }
  end

  it 'validate with valid original_text and translated_text' do
    expect(Card.new(original_text: 'anything', translated_text: 'anything_text')).to be_valid
  end

end
