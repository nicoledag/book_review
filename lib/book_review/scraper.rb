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
        short_desc: book.css("div.views-field.views-field-field-one-liner.one-liner")[0].children.text.strip,
        age: book.css("div.csm-green-age")[0].children.text
        
          }
    
        book = BookReview::Book.new(attributes)
          
     end
end


  def self.scrape_review
    
    review_page = Nokogiri::HTML(open('https://commonsensemedia.org/book-reviews/tales-of-a-fourth-grade-nothing'))
   

  
      doc = review_page.css("div.panel-content-mid-main.panel-panel")
      
      binding.pry
      
     
      # doc.each do |review|    
  
      
      attributes = {}
      
      
        attributes[:story] = doc.css("div.shutter-summary-pane.panel-pane.pane-entity-field.pane-node-field-what-is-story p").text
        
        attributes[:what_parents_need_to_know] = doc.css("div.shutter-summary-pane.panel-pane.pane-entity-field.pane-node-field-parents-need-to-know p").text
        
        attributes[:any_good] = doc.css("div.field.field-name-field-any-good.field-type-text-long.field-label-hidden p").text

        attributes[:families_can_talk_about] = doc.css("div.shutter-summary-pane.panel-pane.pane-entity-field.pane-node-field-family-topics p").text


        # attributes[:what_parents_need_to_know] = doc.css("div.field-item.even p")[0].children.text
        # attributes[:story] = doc.css("div.field-item.even p")[1].children.text
        # attributes[:any_good] = doc.css("div.field-item.even p")[3,4].children.text
        # attributes[:families_can_talk_about] = doc.css("div.field-item.even p")[5].children.text

        
        review = BookReview::Review.new(attributes)
        
      end
  # end
  
  
  
end