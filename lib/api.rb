class Api
  attr_accessor :url, :uri

  def createUser(user, request_method)
  
    json_req = user.to_json
    json_req["score"] = "score_attributes"
  
    request = request_method.new(@url)
    request.add_field "Content-Type", "application/json"
    request.body = json_req
  
    http = Net::HTTP.new(@uri.host, @uri.port)
    response = http.request(request)
  
    response.body
  end
  
  def createTweet(tweet)
    json_req = tweet.to_json
    
    request = Net::HTTP::Post.new(@url)
    request.add_field "Content-Type", "application/json"
    request.body = json_req
    
    http = Net::HTTP.new(@uri.host, @uri.port)
    response = http.request(request)
    
    response.body    
  end
end
