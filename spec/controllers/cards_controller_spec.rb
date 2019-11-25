# frozen_string_literal: true

require 'rails_helper'
require 'card'

RSpec.describe CardsController, :type => :controller do
	# describe 'index action' do
 #    it "assigns_@cards" do
 #      card = Card.all
 #      get :index
 #      expect(assigns(:cards)).to eq(card)
 #    end
 #    it "render_the_index_template" do
 #    	get :index
 #    	expect(response).to render_template("index")
	# 	end
	# end

  describe 'GET #index' do
    it 'return a success response' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      card = FactoryBot.create :card
      get :show, params: { id: card.to_param }
      expect(response).to be_successful
    end
  end
end

describe 'Routing', type: :routing do
  it do
    should route(:get, '/cards', port: 3000).
      to('cards#index')
  end
end
