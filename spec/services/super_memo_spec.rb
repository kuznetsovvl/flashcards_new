# frozen_string_literal: true

require 'rails_helper'

describe SuperMemo do
  let(:card) { create(:card) }
  subject(:result) { described_class.new(card, input) }
  context 'with 5 quality' do
    let(:input) { '5' }
    it 'should change review time in 1 day' do
      result.algorithm
      expect(card.interval).to eq(1)
    end
    it 'should change review time in 6 days' do
      2.times do
        result.algorithm
      end
      expect(card.interval).to eq(6)
    end
  end
  context 'with 3 quality' do
    let(:input) { '3' }
    it 'should change review time in 1 day' do
      2.times do
        result.algorithm
      end
      expect(card.interval).to eq(1)
    end
  end
end
