require 'bundler'
Bundler.require :default, :test

require 'minitest/autorun'

def fixture_path(filename)
  File.expand_path("../fixtures/#{filename}", __FILE__)
end
