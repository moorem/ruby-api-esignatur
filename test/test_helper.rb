require './lib/ruby/api/esignatur'
require 'minitest/autorun'
require 'base64'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
end