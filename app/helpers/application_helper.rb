# frozen_string_literal: true

module ApplicationHelper
  def today_card
    if current_user
      current_user.cards.days_ago.last
    else
      Card.days_ago.last
    end
  end
end
