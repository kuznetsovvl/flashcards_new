# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      let(:attrs) { attributes_for :card }
      before do
        user = create(:user)
        login_user(user)
      end
      it 'creates a new card' do
        expect do
          post :create, params: { card: attrs }
        end.to change(Card, :count).by(1)
      end

      it 'redirects to card' do
        post :create, params: { card: attrs }
        expect(response).to redirect_to cards_path
      end
    end

    context 'with invalid attributes' do
      let(:attrs) { { original_text: nil, translated_text: nil } }
      before do
        user = create(:user)
        login_user(user)
      end
      it 'renders new form' do
        post :create, params: { card: attrs }
        expect(response).to render_template :new
      end
    end
  end
end
