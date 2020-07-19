# frozen_string_literal: true

class RandomCard
  def today_card(user)
    @current_decks = Deck.where(user_id: user.id).last
    @review_cards = pick_card
  end

  private

  def pick_card
    Card.where(deck_id: @current_decks&.id).where('review_time <= ?', Time.now).last
  end
end
