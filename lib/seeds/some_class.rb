class Scraper
  require 'nokogiri'
  require 'open-uri'

  source = 'https://1000mostcommonwords.com/1000-most-common-german-words'
  page = Nokogiri::HTML(open(source))
  page.css('.entry-content tr').take(5).each do |a|
    Card.create!(
      original_text: a.css('td:nth-last-child(2)').text,
      translated_text: a.css('td:last-child').text  
	)
  end
end