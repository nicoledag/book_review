require 'pry'
class BookReview::Review

  attr_accessor :story, :any_good, :parents_need_to_know, :family_topics
  attr_reader :book


@@all = []


  def initialize(att_hash, book = nil)
    att_hash.each { |key, value| self.send("#{key}=", value) }
    self.book = book
    self.save
  end

  def book=(book)
    if book != nil
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
end
