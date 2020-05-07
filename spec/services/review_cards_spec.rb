# frozen_string_literal: true

require 'rails_helper'

describe ReviewCards do
  subject(:result) { described_class.new }
  context 'has card for review' do
    let!(:card) { create(:card, :card_review) }
    it do
      expect(result.find_user_for_review).not_to be_empty
    end
  end
  context 'has not card for review' do
    let!(:card) { create(:card) }
    it do
      expect(result.find_user_for_review).to be_empty
    end
  end
end
