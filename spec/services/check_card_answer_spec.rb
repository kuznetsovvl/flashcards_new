# frozen_string_literal: true

require 'rails_helper'

describe CheckCardAnswer do
  let(:card) { create(:card) }
  subject(:result) { described_class.new(input, card) }
  context 'with correct answer' do
    let(:input) { 'Hola' }
    it do
      expect(result.success?).to be_truthy
    end
  end
  context 'with correct answer with mistakes' do
    let(:input) { 'Hloa' }
    it do
      expect(result.info?).to be_truthy
    end
  end
  context 'with uncorrect answer' do
    let(:input) { 'Error' }
    it do
      expect(result.error?).to be_truthy
    end
  end
end
