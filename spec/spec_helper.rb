require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :development)

require 'yaml'
require 'rubikey' 

LOCAL_ENV = Hash.new
env_file = File.dirname(__FILE__) + '/authentication_fixtures.yml'
YAML.load_file(env_file).each do |key, value|
  LOCAL_ENV[key.to_s] = value
end if File.exists?(env_file) 


RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'

 # config.order = 'random'
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock 
end
