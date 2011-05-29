require 'rubygems'
require 'sinatra'
require 'haml'
require 'ninesixty'
require 'json'
require 'model/Frebbe'
require 'system_timer'
require "rack/sprockets"

use Rack::Sprockets

Rack::Sprockets.configure do |config|
  config.cache = false
  #config.compress = :yui
end

configure :test do
  ENV['AUTOFEATURE'] = "true"
  ENV['RSPEC'] = "true"
end

configure :production  do
    Frebbe.connectUrl
end

configure :development  do
  Frebbe.connect(:server=> 'localhost',:db=> 'frebbe4')
end 

get '/test' do
    haml :index , :layout => :testLayout
end

get '/' do
 haml :index  
end

get '/page' do
 haml :index
end

get '/slides' do
  parentId = params['parentId']
  if parentId == root
    parentId = ""
  end
  presentations = Frebbe.findByParent parentId
  return presentations
end 
 
post '/slide' do
  slide = params['slide']
  return Frebbe.insert(JSON(slide))
end 
 
def render_file(filename)
  contents = File.read('views/'+filename+'.haml')
  Haml::Engine.new(contents).render
end