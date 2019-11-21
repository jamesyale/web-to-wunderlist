#!/usr/bin/ruby

require 'sinatra'
require 'uri'
require 'net/http'

@@key = ENV['KEY']
@@wunderlist = {
  'Client-ID' => ENV['CLIENT_ID'],
  'Access-Token' => ENV['ACCESS_TOKEN'],
  'list_id' => ENV['LIST_ID'].to_i
}

set :port, ENV['PORT'] || 80
set :bind, '0.0.0.0'

configure :production, :development do
  enable :logging
end

def authorized?(key)
  key == @@key
end

def send_request(title)
 
  url = URI("http://a.wunderlist.com/api/v1/tasks?list_id=#{@@wunderlist['list_id']}&title=#{title}")

  http = Net::HTTP.new(url.host, url.port)

  request = Net::HTTP::Post.new(url)
  request["X-Client-ID"] = @@wunderlist['Client-ID']
  request["X-Access-Token"] = @@wunderlist['Access-Token']
  request["Content-Type"] = 'application/json'
  request.body = {
    'list_id' => @@wunderlist['list_id'],
    'title' => title
  }.to_json

  response = http.request(request)
  logger.info "config is #{@@wunderlist}"
  logger.info "request.body was #{request.body}"
  logger.info response.read_body
  true
end

get '/wunderlist/post*' do
  output = ''

  if authorized?(params['key'].to_s)

    output = "Success" if send_request(params['title'])
  
  else
    output = 'Failed'  
  end
  
  output
end