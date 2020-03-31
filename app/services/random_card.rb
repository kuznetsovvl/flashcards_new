# frozen_string_literal: true

class RandomCard
  def today_card(user)
    if @current_decks.present?
			@current_decks = Deck.where(user_id: user.id).last    	
    	Card.where(deck_id: @current_decks.id).days_ago.last
		end
 	end
end
