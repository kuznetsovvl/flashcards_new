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
      flash[:success] = I18n.t 'deck.success.create'
      redirect_to decks_path
    else
      flash[:error] = I18n.t 'deck.error.create'
      render 'new'
    end
  end

  def edit; end

  def show; end

  def destroy
    @deck.destroy
    flash[:success] = I18n.t 'deck.success.destroy'
    redirect_to decks_path
  end

  def new
    @deck = current_user.decks.new
  end

  def update
    if @deck.update(deck_params)
      flash[:success] = I18n.t 'deck.success.update'
      redirect_to decks_path
    else
      flash.now[:error] = I18n.t 'deck.error.update'
      render 'edit'
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
