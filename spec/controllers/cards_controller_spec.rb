# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      let!(:deck) { create(:deck) }
      let(:attrs) { attributes_for(:card, deck: deck) }

      it 'creates a new card' do
        expect do
          post :create, params: { deck_id: deck.id, card: attrs }
        end.to change(Card, :count).by(1)
      end

      it 'redirects to card' do
        post :create, params: { deck_id: deck.id, card: attrs }
        expect(response).to redirect_to deck_cards_path
      end
    end

    context 'with invalid attributes' do
      let(:attrs) { { original_text: nil, translated_text: nil } }
      let!(:deck) { create(:deck) }
      it 'renders new form' do
        post :create, params: { deck_id: deck.id, card: attrs }
        expect(response).to render_template :new
      end
    end
  end
end
