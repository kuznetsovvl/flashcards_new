# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Visitor', type: :feature do
  describe 'Change locale' do
    it 'change locale to russian' do
      visit root_path
      click_link I18n.t('navbar.languages.ru').to_s
      expect(I18n.locale).to eq(:ru)
    end

    it 'change locale to english' do
      visit root_path
      click_link I18n.t('navbar.languages.en').to_s
      visit decks_path
      expect(I18n.locale).to eq(:en)
    end
  end
end
