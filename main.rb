# -*- coding: utf-8 -*-
require 'sinatra'
require 'haml'
require './rst'
require './db'

set :port, 8181
# set :environment, :production

not_found do
  @title = "404"
  myhaml :not_found
end

error do
  @title = "出错鸟"
  myhaml :error
end

get '/' do
  starts = params[:starts] || 10000000
  @articles = Article.first(5, :id.lt => starts, :order => :created.desc)
  myhaml :index 
end

get '/list' do
  @articles = Article.all :order => [:created.desc]
  myhaml :list
end

get '/article/*/' do |title|
  @title = title
  @article = Article.first :title => title
  myhaml :article
end

get '/article/*' do |title|
  @title = title
  @article = Article.first :title => title
  myhaml :article
end

get '/feed' do
  @articles = Article.all :order => [:created.desc]
  @updated = @articles[0].updated
  myhaml :feed, {:layout => false}
end

get '/rss' do
  redirect to '/feed'
end

get '/about' do
  @article = Article.first :title => "机械唯物主义"
  myhaml :article
end

def myhaml target, args={}
  args.merge! :layout => false if params[:_pjax]
  haml target, args
end

def link_to name, link, pjax=""
  pjax = "class=\"js-pjax\"" if pjax
  "<a href=\"#{link}\"#{pjax}>#{name}</a>"
end
