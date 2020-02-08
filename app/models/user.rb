# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :cards

  validates :password, confirmation: true, presence: true
  validates :email, presence: true, uniqueness: true
end
