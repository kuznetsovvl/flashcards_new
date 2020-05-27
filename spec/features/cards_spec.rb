# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Cards', type: :feature do
  describe 'create new card' do
    let!(:deck) { create(:deck) }
    before do
      visit new_deck_card_path(deck)
      find('textarea#card_original_text').set('foo')
    end
    scenario 'successfully creates card' do
      find('textarea#card_translated_text').set('bar')
      attach_file('card_image', "#{Rails.root}/spec/support/test.jpg")
      expect { click_button 'Create Card' }.to change(Card, :count).by(1)
    end
    scenario 'fail to create card' do
      expect { click_button 'Create Card' }.to change(Card, :count).by(0)
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
      find('textarea#card_original_text').set('foo')
      attach_file('card_image', "#{Rails.root}/spec/support/test.jpg")
      click_button 'Update Card'
      expect(page).to have_content(I18n.t('cards.update.success'))
    end
    scenario 'fail to update card' do
      find('textarea#card_original_text').set('')
      click_button 'Update Card'
      expect(page).to have_content(I18n.t('cards.update.error'))
    end
  end

  describe 'destroy card' do
    let!(:deck) { create :deck }
    let!(:card) { create :card, deck: deck }
    before do
      login_scenario
      visit deck_card_path(deck, card)
    end
    scenario 'successfuly destroy card' do
      expect { click_button I18n.t('buttons.destroy').to_s }.to change(Card, :count).by(-1)
    end
  end

  describe 'trainer card is esteblished immediately' do
    let!(:deck) { create :deck }
    let!(:card) { create(:card, updated_at: 10.seconds.ago, deck: deck) }
    before do
      login_scenario
    end
    scenario 'successfully' do
      find('input#other_user_answer').set('Hola')
      click_button I18n.t('buttons.check').to_s
      expect(page).to have_content(I18n.t('cards.trainer.success'))
    end
    scenario 'fail to train card' do
      train_card_scenario
    end
  end

  describe 'trainer card after 12 hours' do
    let!(:deck) { create :deck }
    let!(:card) { create(:card, deck: deck, updated_at: 13.hours.ago, status: 1) }
    before do
      login_scenario
    end
    scenario 'successfully' do
      train_card_scenario
    end
  end

  describe 'trainer card after 3 days' do
    let!(:deck) { create :deck }
    let!(:card) { create(:card, deck: deck, updated_at: 4.days.ago, status: 2) }
    before do
      login_scenario
    end
    scenario 'successfully' do
      train_card_scenario
    end
  end

  describe 'trainer card after 7 days' do
    let!(:deck) { create :deck }
    let!(:card) { create(:card, deck: deck, updated_at: 8.days.ago, status: 3) }
    before do
      login_scenario
    end
    scenario 'successfully' do
      train_card_scenario
    end
  end

  describe 'trainer card after 2 weeks' do
    let!(:deck) { create :deck }
    let!(:card) { create(:card, deck: deck, updated_at: 3.weeks.ago, status: 4) }
    before do
      login_scenario
    end
    scenario 'successfully' do
      train_card_scenario
    end
  end

  describe 'trainer card after 1 month' do
    let!(:deck) { create :deck }
    let!(:card) { create(:card, deck: deck, updated_at: 2.month.ago, status: 5) }
    before do
      login_scenario
    end
    scenario 'successfully' do
      train_card_scenario
    end
  end

  describe 'trainer card with mistakes' do
    let!(:deck) { create :deck }
    let!(:card) { create(:card, :card_review, deck: deck) }
    let(:params) do
      { answer: 'Hloa' }
    end
    before do
      login_scenario
    end
    scenario 'successfully' do
      find('input#other_user_answer').set('Hloa')
      click_button I18n.t('buttons.check').to_s
      expect(page).to have_content(I18n.t('cards.trainer.info', deep_interpolation: true, translated_text: card.translated_text, user_answer: params[:answer]))
    end
  end

  describe 'trainer card' do
    let!(:deck) { create :deck }
    let!(:card) { create(:card, deck: deck, updated_at: 2.month.ago, status: 5) }
    before do
      login_scenario
    end
    scenario 'train card roll back' do
      3.times do
        find('input#other_user_answer').set('Error')
        click_button I18n.t('buttons.check').to_s
      end
      expect(page).to have_content(I18n.t('cards.trainer.count', deep_interpolation: true, mistakes: card.mistake_counter))
    end
  end

  private

  def login_scenario
    visit '/sessions/new'
    find('input#login_email').set('example@mail.com')
    find('input#login_password').set('12345')
    click_button I18n.t('buttons.login').to_s
  end

  def train_card_scenario
    find('input#other_user_answer').set('Hola')
    click_button I18n.t('buttons.check').to_s
    expect(page).to have_content(I18n.t('cards.trainer.success'))
  end
end
