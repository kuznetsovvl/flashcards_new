# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Cards', type: :feature do
  describe 'create new card' do
    let!(:user) { FactoryBot.create :user }
    before do
      visit login_path
      find('input#email').set('example@mail.com')
      find('input#password').set('12345')
      click_button 'Log in'
      visit new_card_path
      find('input#card_original_text').set('foo')
    end
    scenario 'successfully creates card' do
      find('input#card_translated_text').set('bar')
      click_button 'Create Card'
      expect(page).to have_content('The card has created successfully')
    end

    scenario 'fail to create card' do
      click_button 'Create Card'
      expect(page).to have_content('Could not save the card')
    end
  end

  describe 'update card' do
    let!(:card) { FactoryBot.create :card }
    before do
      visit login_path
      find('input#email').set('example@mail.com')
      find('input#password').set('12345')
      click_button 'Log in'
      visit edit_card_path(card)
    end
    scenario 'successfuly update card' do
      find('input#card_original_text').set('foo')
      click_button 'Update Card'
      expect(page).to have_content('The card has updated successfully')
    end

    scenario 'fail to update card' do
      find('input#card_original_text').set('')
      click_button 'Update Card'
      expect(page).to have_content('Could not update the card')
    end
  end

  describe 'destroy card' do
    let!(:card) { FactoryBot.create :card }
    before do
      visit login_path
      find('input#email').set('example@mail.com')
      find('input#password').set('12345')
      click_button 'Log in'
      visit cards_path
    end
    scenario 'successfuly destroy card' do
      click_button 'Destroy', match: :first
      expect(page).to have_content('The card was removed successfully')
    end
  end

  describe 'trainer card' do
    let!(:card) { create(:card, updated_at: 10.days.ago) }
    before do
      visit login_path
      find('input#email').set('example@mail.com')
      find('input#password').set('12345')
      click_button 'Log in'
      visit cards_path
    end
    scenario 'successfully trains card' do
      find('input#other_user_answer').set('Hola')
      click_button 'Check'
      expect(page).to have_content('Awesome!')
    end
    scenario 'fail to train card' do
      find('input#other_user_answer').set('foo')
      click_button 'Check'
      expect(page).to have_content('Try again!')
    end
  end
end
