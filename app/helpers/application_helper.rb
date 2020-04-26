# frozen_string_literal: true

module ApplicationHelper
  def random_card
    RandomCard.new.today_card(current_user) if current_user
  end
end
