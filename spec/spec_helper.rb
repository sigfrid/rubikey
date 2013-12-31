require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :development)

require 'rubikey' 


RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'

  config.order = 'random'
end
