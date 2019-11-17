module ApplicationHelper
	def today_card
	Card.days_ago.last
	end
end
