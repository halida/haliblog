# -*- coding: utf-8 -*-
require 'sinatra'
require 'haml'
require './rst'
require './db'

set :port, 8181

configure do
  mime_type :json, 'application/json'
end

get '/' do
  @articles = Article.all(:order => [:created.desc]).first 5
  haml :index 
end

get '/list' do
  @articles = Article.all :order => [:created.desc]
  haml :list
end

get '/article/:title' do |title|
  @title = title
  @article = Article.first :title => title
  haml :article
end

get '/feed' do
  @articles = Article.all :order => [:created.desc]
  @updated = @articles[0].updated
  haml :feed, {:layout => false}
end

get '/rss' do
  redirect to '/feed'
end

get '/about' do
  redirect to('/article/机械唯物主义')
end

