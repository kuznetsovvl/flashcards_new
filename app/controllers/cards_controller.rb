# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :set_card, except: %i[index new create]
  before_action :require_login

  def index
    @cards = current_user.cards.all
  end

  def show; end

  def new
    @card = current_user.cards.new
  end

  def edit; end

  def create
    @card = current_user.cards.new(card_params)

    if @card.save
      flash[:success] = 'The card has created successfully'
      redirect_to cards_path
    else
      flash.now[:error] = 'Could not save the card'
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      flash[:success] = 'The card has updated successfully'
      redirect_to @card
    else
      flash.now[:error] = 'Could not update the card'
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    flash[:success] = 'The card was removed successfully'
    redirect_to cards_path
  end

  def trainer
    if @card[:translated_text] == params[:other][:user_answer]
      @card.touch
      flash.now[:success] = 'Awesome!'
    else
      flash.now[:error] = 'Try again!'
    end
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image)
  end
end
