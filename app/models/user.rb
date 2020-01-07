# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :cards

  validates :password, confirmation: true, presence: true
  validates :email, presence: true, uniqueness: true
end
