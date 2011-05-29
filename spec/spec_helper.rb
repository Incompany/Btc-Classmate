require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'
require 'rspec/autorun'
require File.join(File.dirname(__FILE__), '..', 'init.rb')

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
