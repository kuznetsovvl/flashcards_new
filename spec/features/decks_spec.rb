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
      expect { click_button 'Create Deck' }.to change(Deck, :count).by(1)
    end

    scenario 'fail to create card' do
      expect { click_button 'Create Deck' }.to change(Deck, :count).by(0)
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
      expect(page).to have_content(I18n.t('decks.update.success'))
    end

    scenario 'fail to update deck' do
      find('input#deck_name').set('')
      click_button 'Update Deck'
      expect(current_path).to eql(deck_path(deck))
    end
  end

  describe 'destroy deck' do
    let!(:deck) { create :deck }
    before do
      login_scenario
      visit decks_path
    end
    scenario 'successfuly destroy deck' do
      expect { click_link I18n.t('buttons.destroy').to_s }.to change(Deck, :count).by(-1)
    end
  end

  private

  def login_scenario
    visit '/sessions/new'
    find('input#login_email').set('example@mail.com')
    find('input#login_password').set('12345')
    click_button I18n.t('buttons.login').to_s
  end
end
