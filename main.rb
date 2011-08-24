require 'sinatra'
require 'haml'

set :port, 8181

configure do
  mime_type :json, 'application/json'
end

get '/' do
  haml :index 
end

get '/list' do
end

get 'article/:name' do
  params[:name]
end

get 'article/:name/S5' do
  params[:name] + " S5"
end



