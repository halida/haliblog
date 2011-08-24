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
  starts = params[:starts] || 10000000
  @articles = Article.first(5, :id.lt => starts, :order => :created.desc)
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
  redirect to('/article/%E6%9C%BA%E6%A2%B0%E5%94%AF%E7%89%A9%E4%B8%BB%E4%B9%89')
end

