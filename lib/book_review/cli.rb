require 'pry'

class BookReview::CLI        #name spacing so it doesn't get confused with soemthing else similiar to it.
  
  def start 
    puts "Welcome to the Children's Book Review App!"
    puts "Here are the top 50 books that all kids should read before they are 12 years old:"
    puts ""
    
    #scrape all the books - call on the scraper class.
    BookReview::Scraper.scrape_book
    
    list_books
    
    #Is there a way to wrap text?
    puts ""
    puts "Would you like more information about each book?"  
    puts "Please select a book you want more info about by choosing a number 1-50"
    
    get_book
   
    # review_method(book)
  
    
    
  end
  
  
  
  def list_books
    BookReview::Book.all.each.with_index(1) do |book,index|
      puts "#{index}: #{book.title}"
    end
  end
  
  
  def get_book
    input = gets.strip
    index = input.to_i - 1  #converting user input to an integer and subracting 1 to get the index
    
    if index.between?(0, 49)
      
      book = list_books[index]  #I am passing the index to the list_books method.
      
      puts ""
      puts "-------------------------------------------------"
      puts "Book title:           #{book.title}"
      puts "Recommended Age:      #{book.age}"
      puts "Author:               #{book.author}"
      puts "Review Link:          #{book.url}"
      puts "Short Description:    #{book.short_desc}"    #need to clean up scraping white space.
      puts " #{book.review}"
      
    elsif input == "exit"  #stops method.
    
    else
      puts "Sorry, I didn't understand"
      get_book  #recursion.  Allows method to start over.
    end
    
  end

  
  
  def review_method(book)
  
    puts "Do you want more info (Y/N)?"
    
    input = "nil"  #default value
    
    until input == "Y" || input == "N"
      input = gets.strip.upcase
    end
    if input == "y"
      BookReview::Scraper.scrape_review(book)
      
    else
      puts "Goodbye!"
    end
  end
  
  
  
end
  