require 'rubygems'
require 'bundler/setup'
require 'tweetstream'
require 'mongo'
require 'mongo_mapper'
require 'eventmachine'
require './lib/user'
require './lib/score'
require './lib/api'

require 'net/http'

class KeywordDaemon

  TBITW_URL = 'http://severe-stream-5654.heroku.com'
  def run

    if( !ENV['RACK_ENV'] ) then
      MongoMapper.connection = Mongo::Connection.new('localhost', 27017, :logger => Logger.new(STDOUT))
      MongoMapper.database = 'twitter_feed_development' 
      puts 'Connection Initiated: '
    end

    # OAuth with twitter
    TweetStream.configure do |config|
      config.consumer_key = 'TH5GpwU3gxweasliVyPPvQ'
      config.consumer_secret = 'jDBJcoDTYk2qav6aWW3oMjM4cYLWnLTBYsrTMkDFic'
      config.oauth_token = '426722149-9M5iroyl5W3x0JEUXYEwJcvD0r12ELU6rctpMIlw'
      config.oauth_token_secret = 'mpgKEz30UBGX7u18wGrzOGIOoxhkbdv7RKtB1AtnM'
      config.auth_method = :oauth
      config.parser = :yajl
    end    

    while true
      begin
        puts 'Starting the Daemon...'
        keyword_list = ['salesforce', 'sfdc', 'crm', 'forcedotcom']
        tweetstream_client = TweetStream::Client.new

        tweetstream_client.track(keyword_list) do |status|

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

        tweetstream_client.on_error do |message|
          puts "Tweetstream client has encountered an error: #{message}"
        end

      rescue #TweetStream::ReconnectError
        puts 'There was a reconnect error but we\'re carrying on..'    
      end
    end

  end
end
