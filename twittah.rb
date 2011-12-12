require 'rubygems'
require 'bundler/setup'
#require 'yajl'
require 'tweetstream'
require 'mongo'
require 'mongo_mapper'
require 'eventmachine'
require './user'
require './score'
require './api'

require 'net/http'

TBITW_URL = 'http://severe-stream-5654.heroku.com'

if( !ENV['RACK_ENV'] ) then
  MongoMapper.connection = Mongo::Connection.new('localhost', 27017, :logger => Logger.new(STDOUT))
  MongoMapper.database = 'twitter_feed_development' 
  puts 'Connection Initiated: '
  #@db = Mongo::Connection.new.db("twitter_feed_development")
  #@db.create_collection("users",:capped => true, :size => 10485760)
end

# class TweetStream::Daemon
#   DEFAULT_OPTIONS = {
#     :monitor => true,
#     :no_pidfiles => false,
#   }
#   
#   def initiliaze(opts = DEFAULT_OPTIONS)
#     @options = opts
#     super({})
#   end
#     
#   def start(path, query_parameters = {}, &block) #:nodoc:
#     # Because of a change in Ruvy 1.8.7 patchlevel 249, you cannot call anymore
#     # super inside a block. So I assign to a variable the base class method before
#     # the Daemons block begins.
#     startmethod = super.start
#     
#     Daemons.run_proc('tweetstream', @options) do
#       super(path, query_parameters, &block)
#     end
#   end
# end

# OAuth with twitter
TweetStream.configure do |config|
  config.consumer_key = 'U2EoHWS8MSyCEZomc9dIA'
  config.consumer_secret = 'Shpt5r1Y35DLpJ5L0nSJAKFbqtYOD9Q1UWucAPN6waA'
  config.oauth_token = '11329872-oCnQRJYD2ND4Rpqidsw7IjOjMKFyLnu469f0crwpg'
  config.oauth_token_secret = 'tBkDM0hz0v94ZnHfGhFHbt8kOOCBzmplJHMHch2g9M'
  config.auth_method = :oauth
  config.parser = :yajl
end    

while true
  begin
    puts 'Starting the Daemon...'
    TweetStream::Daemon.new().track('salesforce','sfdc','crm','forcedotcom') do |status|

      # PUT or POST the user
      twitter_user = status.user
      api = Api.new

      # try find the user in local db
      user = User.all(:twitter_id => twitter_user[:id]).first

      if(user.nil?) then
        user = User.new(:twitter_id => twitter_user[:id], :screen_name => twitter_user[:screen_name], :name => twitter_user[:name], :profile_image_url => twitter_user[:profile_image_url])
    
        user.score = Score.new(:value=>1, :user=>user)
    
        api.url = TBITW_URL + '/users.json'
        api.uri = URI.parse api.url
    
        http_response = api.createUser(user, Net::HTTP::Post)
        user.tbitw_id = Yajl::Parser.parse(http_response)  
    
        user_sr = user.save
        score_sr = user.score.save    
      else
    
        user.score.value += 1
        user.score.update
    
        # update the user on tbitw
        api.url = TBITW_URL + '/users/' + user.tbitw_id.to_s + '.json'
        api.uri = URI.parse api.url    
    
        http_response = api.createUser(user, Net::HTTP::Put)
        user_tbitw_id = Yajl::Parser.parse(http_response)    
      end
  
      tweet = {:tweet => {:user_id => user.tbitw_id, :id_str => status.id_str, :text => status.text, :twitter_created_at => status.created_at, :source => status.source, :twitter_id => status.user.id}}
  
      api.url = TBITW_URL + '/tweets.json'
      api.uri = URI.parse api.url
      http_response = api.createTweet(tweet)
      
      # resetting the lsat tweet
      last_tweet = Time.now
    end  
  rescue #TweetStream::ReconnectError
    puts 'There was a reconnect error but we\'re carrying on..'    
  end
end


