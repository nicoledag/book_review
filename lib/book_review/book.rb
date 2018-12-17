
class BookReview::Book      
  
  attr_accessor :title, :author, :short_desc, :url, :age, :review
  
  @@all = []
  

  def initialize(att_hash)
    att_hash.each do |key, value|
      self.send("#{key}=", value)
    end
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
  