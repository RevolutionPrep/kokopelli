begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue => error
  puts "You need to install rspec in your base app"
  error.backtrace.join("\n")
  exit
end

require 'fakeweb'
require 'fakeweb/mapping'
require 'fakeweb/declaration'

plugin_spec_dir = File.dirname(__FILE__)
RAILS_DEFAULT_LOGGER = Logger.new(STDOUT) if KOKOPELLI[:logging] == true