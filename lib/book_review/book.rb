require 'pry'

class BookReview::Book

  attr_accessor :title, :author, :short_desc, :url, :age
  attr_reader :reviews  #reader for @review array

  @@all = []


  def initialize(att_hash)
    att_hash.each { |key, value|  self.send("#{key}=", value) }   #Mass Assignment
    @reviews = []
    self.save
  end

  def save
    @@all << self
    self
  end

  def self.all
    @@all
  end

  def add_review(review)   #assigns the review to the book then adds the review to the @review array.
    review.book = self unless review.book  #assigns the current book to the review's 'book' property.  (review belongs to book)
    #does not assign the book if the review already has an book.
    @reviews << review unless reviews.include?(review)
    #adds the review to the current book's 'review' array.
    #does not add the review if the already exists.
  end




end
