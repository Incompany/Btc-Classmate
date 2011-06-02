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


get '/test' do
    puts system('ruby spec/frebbe_spec.rb')
    haml :index , :layout => :testLayout
end

get '/' do
 haml :index  
end

get '/page' do
 haml :index
end

 
 

def render_file(filename)
  contents = File.read('views/'+filename+'.haml')
  Haml::Engine.new(contents).render
end