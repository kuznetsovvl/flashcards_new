# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :get_deck, except: %i[trainer]
  before_action :set_card, except: %i[index new create trainer]

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
      flash[:success] = t('.success')
      redirect_to @deck
    else
      flash.now[:error] = t('.error')
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      flash[:success] = t('.success')
      redirect_to @deck
    else
      flash.now[:error] = t('.error')
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    flash[:success] = t('.success')
    redirect_to @deck
  end

  def trainer
    @card = RandomCard.new.today_card(current_user)
    @result = CheckCardAnswer.new(params[:other][:user_answer], @card)
    flash.now[:success] = t('.success') if @result.success?
    flash.now[:info] = flash_info if @result.info?
    if @result.error?
      flash.now[:error] = t '.error'
      flash.now[:info] = I18n.t 'cards.trainer.count', deep_interpolation: true, mistakes: @card.mistake_counter
    end
  end

  private

  def flash_info
    I18n.t'cards.trainer.info', deep_interpolation: true, translated_text: @card.translated_text, user_answer: params[:other][:user_answer]
  end

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
