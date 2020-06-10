# frozen_string_literal: true

class DecksController < ApplicationController
  before_action :set_deck, except: %i[index new create]
  before_action :require_login

  def index
    @decks = current_user.decks.all
  end

  def create
    @deck = current_user.decks.new(deck_params)

    if @deck.save
      redirect_to decks_path, success: t('.success')
    else
      render 'new', error: t('.error')
    end
  end

  def edit; end

  def show; end

  def destroy
    @deck.destroy
    redirect_to decks_path, success: t('.success')
  end

  def new
    @deck = current_user.decks.new
  end

  def update
    if @deck.update(deck_params)
      redirect_to decks_path, success: t('.success')
    else
      render 'edit', error: t('.error')
    end
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name)
  end
end
