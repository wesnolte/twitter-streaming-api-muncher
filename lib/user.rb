class User
  include MongoMapper::Document
  
  key :twitter_id, Integer
  key :tbitw_id, Integer
  key :screen_name, String
  key :name
  key :profile_image_url
  
  one :score
  
  timestamps!
  
  validates_presence_of :twitter_id
  validates_presence_of :screen_name
  validates_presence_of :name 
  validates_presence_of :profile_image_url
  
  def as_json(option={})
   {
     'user' => {
       :name       => self.name,
       :screen_name => self.screen_name,
       :profile_image_url => self.profile_image_url,
       :score      => self.score
     }
   }
  end
end
