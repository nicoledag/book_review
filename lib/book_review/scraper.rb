require 'pry'
require 'open-uri'


class BookReview::Scraper
  
  
  def self.scrape_book

     html = open('https://www.commonsensemedia.org/lists/50-books-all-kids-should-read-before-theyre-12')

     doc = Nokogiri::HTML(html) 
      
     attributes = {}

     attributes[:review_link] = doc.css("div.views-field.views-field-title.result-title a")[0].attribute("href").value
     attributes[:title] = doc.css("div.views-field.views-field-title.result-title a")[0].children.text
     attributes[:author] = doc.css("em.field-content")[0].children.text
     attributes[:short_desc] = doc.css("div.views-field.views-field-field-one-liner.one-liner")[0].children.text
     attributes[:age] = doc.css("div.csm-green-age")[0].children.text
     
    attributes 
    
    book = BookReview::Book.new(attributes)
     
  end
  
end