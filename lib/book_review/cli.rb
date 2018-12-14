require 'pry'

class BookReview::CLI        #name spacing so it doesn't get confused with soemthing else similiar to it.
  
  def start 
    puts "Welcome to the Children's Book Review App!"
    puts "Here are the top 50 books that all kids should read before they are 12 years old:"
    
    #scrape all the books - call on the scraper class.
    BookReview::Scraper.scrape_book
    
    list_books
    
    #Is there a way to wrap text?
    puts "Would you like more information about each book?"  
    puts "Please select a book you want more info about by choosing a number 1-50"
    
    get_book
    
    puts "Would you like to see books by age range?"
    puts "select (Preschoolers) for ages 2-4, (Little kids) for ages 5-7, (Big kids)" 
    puts "for ages 8-9 and (Tweens) for ages 10-12."
    
    books_by_age_range
    
    
    
    #ask for input
    #call another method
    
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
      
      puts "Book Title: #{book.title}"
      puts "Recommended Age:  #{book.age}"
      puts "Author:  #{book.author}"
      puts "Review Link:  #{book.review_link}"
      puts "Short Description:  #{book.short_desc}"    #need to clean up scraping white space.
      
    elsif input == "exit"  #stops method.
    
    else
      puts "Sorry, I didn't understand"
      get_book  #recursion.  Allows method to start over.
    end
    
  end
  
  def books_by_age_range
    
    input = gets.strip
    
    if input.include?("Preschoolers")
    
      BookReview::Book.all.collect do |book| 
      
       book.age == "age 2+" && book.age == "age 3+"&&  book.age == "age 4+"
        
      puts "Book Title: #{book.title}"
      puts "Recommended Age:  #{book.age}"
      puts "Author:  #{book.author}"
      puts "Review Link:  #{book.review_link}"
      puts "Short Description:  #{book.short_desc}"
     end
    end
    
  end
  
end
  