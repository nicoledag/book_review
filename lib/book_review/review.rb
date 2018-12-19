require 'pry'
class BookReview::Review

  attr_accessor :book, :story, :any_good, :parents_need_to_know, :family_topics


  @@all = []

  def initialize(att_hash)
    att_hash.each { |key, value| self.send("#{key}=", value) }  #Mass Assignment
    self.save
  end

  def save
    @@all << self
    self
  end

  def self.all
    @@all
  end


end
