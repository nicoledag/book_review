require 'pry'
require 'open-uri'


class BookReview::Scraper
  
  
  def self.scrape_book

     index_page = Nokogiri::HTML(open('https://www.commonsensemedia.org/lists/50-books-all-kids-should-read-before-theyre-12'))
      
      doc = index_page.css("div.views-row")
      
      doc.each do |book|
        
       attributes = {

        review_link: book.css("div.views-field.views-field-title.result-title a").attribute("href").value,
        title: book.css("div.views-field.views-field-title.result-title a")[0].children.text,
        author: book.css("em.field-content")[0].children.text,
        
        #need to clean up scraping white space.
        
        short_desc: book.css("div.views-field.views-field-field-one-liner.one-liner")[0].children.text,
        age: book.css("div.csm-green-age")[0].children.text
        
          }
    
        book = BookReview::Book.new(attributes)
          
     end
end


  def self.scrape_review
    
     index_page = Nokogiri::HTML(open('https://www.commonsensemedia.org/book-reviews/dont-let-the-pigeon-drive-the-bus'))
      
      doc = index_page.css("div.views-row")
      
      doc.each do |book|
        
       attributes = {
  
    
        media_review: doc.css(“div.field-item.even p”).text
    
        user_review: doc.css("div.review-wrapper")[0].children[1].text
    
    
        user_review_link:  doc.css("div.review-wrapper a").attribute("href").value

       }
    
        review = BookReview::Review.new(attributes)
    
  end
  
end