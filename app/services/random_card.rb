# frozen_string_literal: true

class RandomCard
  CHECKS = { 0 => proc { 2.seconds.ago },
             1 => proc { 12.hours.ago },
             2 => proc { 3.days.ago.to_date },
             3 => proc { 7.days.ago.to_date },
             4 => proc { 2.weeks.ago.to_date },
             5 => proc { 1.month.ago.to_date } }.freeze

  def today_card(user)
    @current_decks = Deck.where(user_id: user.id).last
    @review_cards = (0..5).map { |e| e = check(e) }
    @review_cards.compact.last
  end

  private

  def check(number)
    Card.where(deck_id: @current_decks&.id).where('updated_at <= ?', CHECKS[number].call).where('status = ?', number).last
  end
end
