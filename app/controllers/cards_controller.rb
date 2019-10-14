class CardsController < ApplicationController
  def index

    @cards = Card.all		
     Rails.logger.debug "#{@cards.to_a.inspect}"
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
    Rails.logger.debug "#{@cards.to_a}"
  	@card = Card.find(params[:id])
  	@card.destroy

  	redirect_to cards_path
  end

  private
    def card_params
    	params.require(:card).permit(:original_text, :translated_text)
    end
end
