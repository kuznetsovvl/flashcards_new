# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      let(:attrs) { attributes_for :user }
      it 'creates a new user' do
        expect do
          post :create, params: { user: attrs }
        end.to change(User, :count).by(1)
      end
      it 'redirect to root' do
        post :create, params: { user: attrs }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      let(:attrs) { { email: nil, password: nil, password_confirmation: nil } }
      it 'render to new' do
        post :create, params: { user: attrs }
        expect(response).to render_template :new
      end
    end
  end
end
