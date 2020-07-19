# frozen_string_literal: true

require 'rails_helper'

describe CheckCardAnswer do
  let(:card) { create(:card) }
  let(:args) { { user_answer: 'Hola', card: card } }
  subject(:result) { described_class.new(args) }
  context 'with correct answer' do
    let(:args) { { user_answer: 'Hola', card: card } }
    it do
      expect(result.success?).to be_truthy
    end
  end
  context 'with correct answer with mistakes' do
    let(:args) { { user_answer: 'Hloa', card: card } }
    it do
      expect(result.info?).to be_truthy
    end
  end
  context 'with uncorrect answer' do
    let(:args) { { user_answer: 'Error', card: card } }
    it do
      expect(result.error?).to be_truthy
    end
  end
end
