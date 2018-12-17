require 'pry'
require 'open-uri'


class BookReview::Scraper
  
  
  def self.scrape_book

     index_page = Nokogiri::HTML(open('https://commonsensemedia.org/lists/50-books-all-kids-should-read-before-theyre-12'))
     
       
      
      doc = index_page.css("div.views-row")
      
      doc.each do |book|
        
       attributes = {

        url: "https://commonsensemedia.org" << book.css("div.views-field.views-field-title.result-title a").attribute("href").value,
        title: book.css("div.views-field.views-field-title.result-title a")[0].children.text,
        author: book.css("em.field-content")[0].children.text,
        
        #need to clean up scraping white space.
        
        short_desc: book.css("div.views-field.views-field-field-one-liner.one-liner")[0].children.text.strip,
        age: book.css("div.csm-green-age")[0].children.text
        
          }
    
        book = BookReview::Book.new(attributes)
          
     end
end


  def self.scrape_review
    
    review_page = Nokogiri::HTML(open('https://commonsensemedia.org/book-reviews/the-snowy-day'))
    binding.pry

  
      doc = review_page.css("div.field-items")
      
     
      doc.each do |review|    
  
      
      attributes = {

   
        story: review.css("div.field-item.even p")[4].text,
        any_good: review.css("div.field-item.even p")[6,7].text,
        what_parents_need_to_know: review.css("div.field-item.even p")[3].text,
        families_can_talk_about: review.css("div.field-item.even p")[8,9].text,

        }
    
        review = BookReview::Review.new(attributes)
        
      end
  end
  
  
  
end