# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DecksController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      let!(:attrs) { attributes_for :deck }
      let!(:user) { create :user }
      before do
        login_user(user)
      end

      it 'creates a new deck' do
        expect do
          post :create, params: { deck: attrs }
        end.to change(Deck, :count).by(1)
      end
      it 'redirects to deck' do
        post :create, params: { deck: attrs }
        expect(response).to redirect_to decks_path
      end
    end

    context 'with invalid attributes' do
      let(:attrs) { { name: nil } }
      let!(:user) { create :user }
      before do
        login_user(user)
      end
      it 'renders new form' do
        post :create, params: { deck: attrs }
        expect(response).to render_template :new
      end
    end
  end
end
