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
      flash[:success] = "The card have created successfully"
      redirect_to @card
    else
      render 'new'
    end
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to cards_path
  end

  def trainer
    @card = Card.find(params[:id])
    @check = @card[:translated_text]
    @answer = params[:other][:user_answer]

    if @check == @answer
      @card.update(:updated_at => Time.now)
      flash.now[:success] = "Awesome!"
    else
      flash.now[:error] = "Try again!"
    end
  end

private
  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end
end
