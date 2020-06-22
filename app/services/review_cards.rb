# frozen_string_literal: true

class ReviewCards
  def find_user_for_review
    User.joins(:decks).where(decks: { id: cardfinder_for_review })
  end

  private

  def cardfinder_for_review
    Card.where('review_time < ?', Time.now).map(&:deck_id)
  end
end
