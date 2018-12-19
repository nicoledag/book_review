require 'pry'
class BookReview::Review

  attr_accessor :story, :any_good, :parents_need_to_know, :family_topics
  attr_reader :book



  @@all = []

  def initialize(att_hash)
    att_hash.each { |key, value| self.send("#{key}=", value) }
    self.save
  end

  def book=(book)  #need to re-look at adding to book class
      @book = book
      book.add_review(self)
  end


  def save
    @@all << self
    self
  end

  def self.all
    @@all
  end


end
