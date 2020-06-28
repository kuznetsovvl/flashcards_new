# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'
gem 'airbrake'
gem 'aws-sdk-s3', '~> 1.0.0.rc2'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'damerau-levenshtein', '~> 1.1'
gem 'fabrication'
gem 'http_accept_language'
gem 'jbuilder', '~> 2.7'
gem 'newrelic_rpm'
gem 'nokogiri'
gem 'paperclip'
gem 'pg', '~> 0.21'
gem 'pry'
gem 'puma', '~> 3.11'
gem 'rails', '~> 6.0.0'
gem 'rake', '~> 12.3', '>= 12.3.3'
gem 'rmagick'
gem 'rubocop', '~> 0.75.1', require: false
gem 'sass-rails', '~> 5'
gem 'simple_form'
gem 'slim-rails'
gem 'sorcery'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'figaro'
  gem 'rspec-core'
  gem 'rspec-expectations'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'rspec-support'
  gem 'simplecov', require: false, group: :test
  gem 'travis'
end

group :development do
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'capybara-screenshot'
  gem 'database_cleaner', '1.0.0.RC1'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
  gem 'vcr'
  gem 'webdrivers'
  gem 'webmock'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
