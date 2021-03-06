# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :get_deck, except: %i[trainer]
  before_action :set_card, except: %i[index new create trainer]
  skip_before_action :verify_authenticity_token

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
      redirect_to @deck, success: t('.success')
    else
      render 'new', notice: t('.error')
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @deck, success: t('.success')
    else
      render 'edit', error: t('.error')
    end
  end

  def destroy
    @card.destroy
    redirect_to @deck, error: t('.success')
  end

  def trainer
    @card = RandomCard.new.today_card(current_user)
    @result = CheckCardAnswer.new(user_answer: params[:other][:user_answer],
                                  card: @card,
                                  quality: params[:other][:quality])
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
    params.require(:card).permit(:original_text, :translated_text, :mistake_counter, :image)
  end
end
