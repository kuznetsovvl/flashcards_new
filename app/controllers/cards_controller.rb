# frozen_string_literal: true

class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
    @card = Card.new
  end

  def edit
    @card = Card.find(params[:id])
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      flash[:success] = 'The card has created successfully'
      redirect_to cards_path
    else
      flash.now[:error] = 'Could not save the card'
      render 'new'
    end
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      flash[:success] = 'The card has updated successfully'
      redirect_to @card
    else
      flash.now[:error] = 'Could not update the card'
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    flash[:success] = 'The card was removed successfully'
    redirect_to cards_path
  end

  def trainer
    @card = Card.find(params[:id])
    if @card[:translated_text] == params[:other][:user_answer]
      @card.touch
      flash.now[:success] = 'Awesome!'
    else
      flash.now[:error] = 'Try again!'
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end
end
