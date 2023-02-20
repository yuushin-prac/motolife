source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

gem "rails", "~> 7.0.4"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'dotenv-rails'
gem "rb-readline"
gem "sass-rails"
gem 'bootstrap', '~> 5.1', '>= 5.1.3'
gem "devise"
gem "refile", require: "refile/rails", github: 'manfe/refile'
gem "refile-mini_magick"
gem 'kaminari'
gem 'jquery-rails'
gem 'image_processing'
gem 'mini_magick'

group :development, :test do
  gem "pg", "~> 1.1"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rspec-rails'
  gem "factory_bot_rails"
  gem 'faker'
  gem 'database_cleaner'
end

group :production, :staging do
  gem 'unicorn', platforms: %i[ mswin ]
  gem 'mysql2'
  gem "aws-sdk-s3", require: false
end