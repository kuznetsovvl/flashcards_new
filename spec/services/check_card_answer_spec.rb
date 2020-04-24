# frozen_string_literal: true

require 'rails_helper'

describe CheckCardAnswer do
  let(:card) { create(:card) }

  describe '.success?' do
    it 'return true' do
      result = CheckCardAnswer.new('Hola', card)
      expect(result.success?).to be_truthy
    end
    it 'return false' do
      result = CheckCardAnswer.new('Hloa', card)
      expect(result.success?).to be_falsey
    end
  end
  describe '.info?' do
    it 'return true' do
      result = CheckCardAnswer.new('Hloa', card)
      expect(result.info?).to be_truthy
    end
    it 'return false' do
      result = CheckCardAnswer.new('Hola', card)
      expect(result.info?).to be_falsey
    end
  end
  describe '.error?' do
    it 'return true' do
      result = CheckCardAnswer.new('Error', card)
      expect(result.error?).to be_truthy
    end
    it 'return false' do
      result = CheckCardAnswer.new('Hola', card)
      expect(result.info?).to be_falsey
    end
  end
end
