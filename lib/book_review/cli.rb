class BookReview::CLI        #name spacing so it doesn't get confused with soemthing else similiar to it.
  
  def start 
    puts "Welcome to the Children's Book Review App!"
    puts "Here are the top 50 books that all kids should read before they are 12 years old: "
    #scrape all the books - call on the scraper class.
    BookReview::Scraper.scrape_book
    
    list_books
    
    #ask for input
    #call another method
    
  end
  
  def list_books
    book.each.with_index(1) do |book,index|
      puts "#{index}. #{book.title}"
    end
  end
  
end
  