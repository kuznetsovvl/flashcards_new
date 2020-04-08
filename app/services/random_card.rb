# frozen_string_literal: true

class RandomCard
  def today_card(user)
    @current_decks = Deck.where(user_id: user.id).sample
    until @current_decks.nil?

      @show = []
      @now = card_of_user.start_check.last
      @h_12 = card_of_user.first_check.last
      @d_3 = card_of_user.second_check.last
      @d_7 = card_of_user.third_check.last
      @w_2 = card_of_user.fourth_check.last
      @m_1 = card_of_user.fifth_check.last
      @array = [@now, @h_12, @d_3, @d_7, @w_2, @m_1]

      @array.map { |e| !e.nil? ? @show << e : false }
      return @show.last
    end
   end

  def card_of_user
    Card.where(deck_id: @current_decks.id)
  end
end
