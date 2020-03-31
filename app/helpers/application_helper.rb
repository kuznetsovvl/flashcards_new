# frozen_string_literal: true

module ApplicationHelper
  def random_card
    if current_user
      RandomCard.new.today_card(current_user)
    else
      Card.days_ago.last
    end
  end
end
