# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  let!(:user) { create(:user) }
  it do
    should validate_uniqueness_of(:email)
  end
  it { should validate_confirmation_of(:password) }
end
