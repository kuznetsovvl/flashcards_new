# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Decks', type: :feature do
  describe 'create new deck' do
    let!(:deck) { create(:deck) }
    before do
      login_scenario
      visit new_deck_path
    end
    scenario 'successfully creates deck' do
      find('input#deck_name').set('Example')
      click_button 'Create Deck'
      expect(page).to have_content(I18n.t('deck.success.create'))
    end

    scenario 'fail to create card' do
      click_button 'Create Deck'
      expect(page).to have_content(I18n.t('deck.error.create'))
    end
  end

  describe 'update deck' do
    let!(:deck) { create :deck }
    before do
      login_scenario
      visit edit_deck_path(deck)
    end
    scenario 'successfuly update deck' do
      find('input#deck_name').set('foo')
      click_button 'Update Deck'
      expect(page).to have_content(I18n.t('deck.success.update'))
    end

    scenario 'fail to update card' do
      find('input#deck_name').set('')
      click_button 'Update Deck'
      expect(page).to have_content(I18n.t('deck.error.update'))
    end
  end

  private

  def login_scenario
    visit '/sessions/new'
    find('input#email').set('example@mail.com')
    find('input#password').set('12345')
    within('.actions') do
      click_button 'Log in'
    end
  end
end
