# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @cards = Card.all
  end
end
