require 'nokogiri'
require 'open-uri'

class Scraper
  SOURCE = 'https://1000mostcommonwords.com/1000-most-common-german-words'
  def scraper_cards
    page
    scraper_table
  end

  def page
    page = Nokogiri::HTML(open(SOURCE))
  end

  def scraper_table
    page.css('.entry-content tr').take(5).each do |a|
      Card.create!(
        original_text: a.css('td:nth-last-child(2)').text,
        translated_text: a.css('td:last-child').text
      )
    end
  end
end
