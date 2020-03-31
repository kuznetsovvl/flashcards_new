# frozen_string_literal: true

class RandomCard
  def today_card(user)
    @current_decks = Deck.where(user_id: user.id).sample  
    unless @current_decks.nil?
      Card.where(deck_id: @current_decks.id).days_ago.last
    end
 	end
end
