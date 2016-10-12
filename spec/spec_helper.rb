ENV["RACK_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'
require 'database_cleaner'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.include Capybara::DSL

  c.before(:all) do
    DatabaseCleaner.clean
  end
  c.after(:each) do
    DatabaseCleaner.clean
  end
end

def new_client
  Client.create(identifier: "google", root_url: "http://google.com")
end

def new_payload
  client_data = {identifier: "google"}
  parsed_data = PayloadParser.parser('{"url":"http://google.com/about","requestedAt":"2013-01-16 23:38:28 -0700","respondedIn":90,"referredBy":"http://apple.com","requestType":"GET","eventName": "show","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1080","ip":"59.29.38.23"}')
  payload = PayloadBuilder.build(parsed_data, client_data[:identifier])
  payload.save
end

def second_payload
  client_data = {identifier: "google"}
  parsed_data = PayloadParser.parser('{"url":"http://google.com/about","requestedAt":"2013-01-16 22:38:28 -0700","respondedIn":32,"referredBy":"http://apple.com/research","requestType":"GET","eventName": "show","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1080","ip":"59.29.38.21"}')
  payload = PayloadBuilder.build(parsed_data, client_data[:identifier])
  payload.save
end
