# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Cards', type: :feature do
  describe 'create new card' do
    let!(:deck) { create(:deck) }
    before do
      visit new_deck_card_path(deck)
      find('input#card_original_text').set('foo')
    end
    scenario 'successfully creates card' do
      find('input#card_translated_text').set('bar')
      attach_file('card_image', "#{Rails.root}/spec/support/test.jpg")
      click_button 'Create Card'
      expect(page).to have_content(I18n.t('cards.success.create'))
    end

    scenario 'fail to create card' do
      click_button 'Create Card'
      expect(page).to have_content(I18n.t('cards.error.create'))
    end
  end

  describe 'update card' do
    let!(:deck) { create :deck }
    let(:card) { create(:card, deck: deck) }
    before do
      login_scenario
      visit edit_deck_card_path(deck, card)
    end
    scenario 'successfuly update card' do
      find('input#card_original_text').set('foo')
      attach_file('card_image', "#{Rails.root}/spec/support/test.jpg")
      click_button 'Update Card'
      expect(page).to have_content(I18n.t('cards.success.update'))
    end

    scenario 'fail to update card' do
      find('input#card_original_text').set('')
      click_button 'Update Card'
      expect(page).to have_content(I18n.t('cards.error.update'))
    end
  end

  describe 'destroy card' do
    let!(:deck) { create :deck }
    let!(:card) { create :card, deck: deck }
    before do
      login_scenario
      visit deck_path(deck)
    end
    scenario 'successfuly destroy card' do
      expect { click_button 'Destroy' }.to change(Card, :count).by(-1)
    end
  end

  describe 'trainer card is esteblished immediately' do
    let!(:deck) { create :deck }
    let(:card) { create(:card, deck: deck, updated_at: 10.seconds.ago) }
    before do
      login_scenario
      visit decks_path(deck, card)
    end
    scenario 'successfully' do
      find('input#other_user_answer').set('Hola')
      click_button 'Check'
      expect(page).to have_content(I18n.t('trainer.success'))
    end
    scenario 'fail to train card' do
      train_card_scenario
    end
  end

  describe 'trainer card after 12 hours' do
    let!(:deck) { create :deck }
    let(:card) { create(:card, deck: deck, updated_at: 13.hours.ago, status: 1) }
    before do
      login_scenario
      visit decks_path(deck, card)
    end
    scenario 'successfully' do
      train_card_scenario
    end
  end

  describe 'trainer card after 3 days' do
    let!(:deck) { create :deck }
    let(:card) { create(:card, deck: deck, updated_at: 4.days.ago, status: 2) }
    before do
      login_scenario
      visit decks_path(deck, card)
    end
    scenario 'successfully' do
      train_card_scenario
    end
  end

  describe 'trainer card after 7 days' do
    let!(:deck) { create :deck }
    let(:card) { create(:card, deck: deck, updated_at: 8.days.ago, status: 3) }
    before do
      login_scenario
      visit decks_path(deck, card)
    end
    scenario 'successfully' do
      train_card_scenario
    end
  end

  describe 'trainer card after 2 weeks' do
    let!(:deck) { create :deck }
    let(:card) { create(:card, deck: deck, updated_at: 3.weeks.ago, status: 4) }
    before do
      login_scenario
      visit decks_path(deck, card)
    end
    scenario 'successfully' do
      train_card_scenario
    end
  end

  describe 'trainer card after 1 month' do
    let!(:deck) { create :deck }
    let(:card) { create(:card, deck: deck, updated_at: 2.month.ago, status: 5) }
    before do
      login_scenario
      visit decks_path(deck, card)
    end
    scenario 'successfully' do
      train_card_scenario
    end
  end

  describe 'trainer card with mistakes' do
    let!(:deck) { create :deck }
    let(:card) { create(:card, deck: deck, updated_at: 10.seconds.ago) }
    before do
      login_scenario
      visit decks_path(deck, card)
    end
    scenario 'successfully' do
      find('input#other_user_answer').set('Hloa')
      click_button 'Check'
      expect(page).to have_content(I18n.t('trainer.success'))
    end
  end

  describe 'trainer card' do
    let!(:deck) { create :deck }
    let(:card) { create(:card, deck: deck, updated_at: 2.month.ago, status: 5) }
    before do
      login_scenario
      visit decks_path(deck, card)
    end
    scenario 'train card roll back' do
      find('input#other_user_answer').set('Error')
      click_button 'Check'
      find('input#other_user_answer').set('Error')
      click_button 'Check'
      find('input#other_user_answer').set('Error')
      click_button 'Check'
      expect(page).to have_content(I18n.t('trainer.forgotten_word'))
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

    def train_card_scenario
      find('input#other_user_answer').set('Hola')
      click_button 'Check'
      expect(page).to have_content(I18n.t('trainer.success'))
    end
  end
end
