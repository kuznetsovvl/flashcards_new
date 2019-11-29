# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    original_text { 'Hello' }
    translated_text { 'Hola' }
  end
end
