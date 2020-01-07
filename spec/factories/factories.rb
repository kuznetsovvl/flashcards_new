# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'example@mail.com' }
    password { '12345' }
    password_confirmation { '12345' }
  end

  factory :card do
    user
    original_text { 'Hello' }
    translated_text { 'Hola' }
    updated_at { Time.now }
  end
end
