# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :get_deck, except: %i[trainer]
  before_action :set_card, except: %i[index new create trainer]

  MAX_MISTAKE = 3

  def index
    @cards = @deck.cards
  end

  def show; end

  def new
    @card = @deck.cards.new
  end

  def edit; end

  def create
    @card = @deck.cards.new(card_params)

    if @card.save
      flash[:success] = I18n.t 'cards.success.create'
      redirect_to deck_cards_path
    else
      flash.now[:error] = I18n.t 'cards.error.create'
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      flash[:success] = I18n.t 'cards.success.update'
      redirect_to @deck
    else
      flash.now[:error] = I18n.t 'cards.error.update'
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    flash[:success] = I18n.t 'cards.success.destroy'
    redirect_to decks_path
  end

  def trainer
    @card = RandomCard.new.today_card(current_user)
    if @card[:translated_text].downcase == params[:other][:user_answer].downcase
      RandomCard.new.trainer_correct_answer(@card)
      flash.now[:success] = I18n.t 'trainer.success'
    else @card.mistake_counter += 1
         if @card.mistake_counter == 3
           RandomCard.new.trainer_wrong_answer(@card)
           flash.now[:error] = I18n.t 'trainer.forgotten_word'
         else
           @card.save!(touch: false)
           flash.now[:info] = I18n.t 'trainer.error'
           flash.now[:error] = I18n.t 'trainer.count', deep_interpolation: true, mistakes: @card.mistake_counter
         end
    end
  end

  private

  def set_card
    @card = @deck.cards.find(params[:id])
  end

  def get_deck
    @deck = Deck.find(params[:deck_id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :updated_at, :status, :mistake_counter, :image)
  end
end
