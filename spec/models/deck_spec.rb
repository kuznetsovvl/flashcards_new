# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Deck, type: :model do
  describe 'validation tests' do
    it { should validate_presence_of(:name) }
  end
end
