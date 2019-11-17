class WelcomeController < ApplicationController
  def index
  	@cards = Card.all
  end
end
