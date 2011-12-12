class Score
  include MongoMapper::Document
  
  key :value, Integer, :default => 0
  
  one :user
  
  validates_presence_of :user, :value
  
  def as_json(options ={}) 
    {
      :value  => self.value
    }
  end
end