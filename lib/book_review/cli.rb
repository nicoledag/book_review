class BookReview::CLI        #name spacing so it doesn't get confused with soemthing else similiar to it.

  def start
    puts " "
    puts "Welcome to the Children's Book Review App!".colorize(:red)
    puts "Here are the top 50 books that all kids should read before they are 12 years old:".colorize(:red)
    puts " "

    BookReview::Scraper.scrape_book  #scrape all the books - call on the scraper class.

    list_books

    puts " "
    puts "Please select a book you want more info about by choosing a number 1-50".colorize(:red)

    get_book
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
      #needed a instance variable so it could be read in other methods.

      puts ""
      puts "-------------------------------------------------".colorize(:red)
      puts "Book title:".colorize(:light_blue) + "        #{book.title}"
      puts "Recommended Age:".colorize(:light_blue) + "   #{book.age}"
      puts "Author:".colorize(:light_blue) + "            #{book.author}"
      puts "Review Link:".colorize(:light_blue) + "       #{book.url}"
      puts "Short Description:".colorize(:light_blue) + " #{book.short_desc}"

      more_info(book)  #calls on the more_info(book) method

      puts " "
      puts "Please select a book you want more info about by choosing a number 1-50 or type 'exit' to Exit".colorize(:red)

      get_book #recursion


    #executes below code if index.between?(0, 49) is not met.
    elsif input == "exit"  #stops method.

    else
      puts "Sorry, I didn't understand"
      get_book  #recursion
    end
  end


  def more_info(book)  #passing in a book object
    puts " "
    puts "Would you like to see the Review (Y/N)?".colorize(:red)

    input = gets.strip.upcase

    until ["Y","N","YES","NO"].include?(input)
      puts "Please type Y or N"  #will prompt if input is not ["Y","N","YES","NO"].  If not program will pass.
      input = gets.strip.upcase
    end

    if input == "Y" || input == "YES"
      puts "... fetching the review \n\n"

      if book.reviews == []
        BookReview::Scraper.scrape_review(book)
      end

      book.reviews.each do |review|
        puts "The Story:".colorize(:light_blue)
        puts "#{review.story}"
        puts "Any Good?:".colorize(:light_blue)
        puts "#{review.any_good}"
        puts "What Parents Need to Know:".colorize(:light_blue)
        puts "#{review.parents_need_to_know}"
        puts "Family Topics:".colorize(:light_blue)
        puts "#{review.family_topics}"
      end

    else
      puts "Goodbye!"
    end
  end

end
