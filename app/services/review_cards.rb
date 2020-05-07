# frozen_string_literal: true

class ReviewCards < RandomCard
  def find_user_for_review
    User.joins(:decks).where(decks: { id: find_deck_for_review })
  end

  private

  def find_deck_for_review
    (CHECKS.keys.first..CHECKS.keys.last).map { |e| e = check_review(e) }.compact.flatten.uniq
  end

  def check_review(number)
    Card.where('updated_at <= ?', CHECKS[number].call).where('status = ?', number).map(&:deck_id)
  end
end
