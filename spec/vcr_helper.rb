require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :development)

require 'rubikey' 


RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock 
end