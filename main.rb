# -*- coding: utf-8 -*-
require 'sinatra'

require 'haml'
require 'sass'
require 'compass'

require 'coffee-script'

require './rst'
require './db'

configure do
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'views'
  end

  set :haml, { :format => :html5 }
  set :sass, Compass.sass_engine_options
end

module Sinatra
  module RenderPartial
    def partial(page, options={})
      haml page, options.merge!(:layout => false)
    end
  end
  helpers RenderPartial
end

set :port, 8181
set :host, "0.0.0.0"
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
  from = params[:from] || 10000000
  @articles = Article.first(5, :id.lt => from, :order => :created.desc)
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
  @articles = Article.first(5, :order => [:created.desc] )
  @updated = @articles[0].updated
  myhaml :feed, {:layout => false}
end

get '/about' do
  @article = Article.first :title => "机械唯物主义"
  myhaml :article
end

get '/sitemap.xml' do
  @articles = Article.all :order => [:created.desc]
  haml :sitemap, {:layout => false}
end

def myhaml target, args={}
  args.merge! :layout => false if params[:_pjax]
  haml target, args
end

def link_to name, link, pjax=""
  pjax = "class=\"js-pjax\"" unless pjax == ""
  "<a href=\"#{link}\"#{pjax}>#{name}</a>"
end

get '/main.css' do
  sass :main
end

get '/main.js' do
  coffee :main
end
