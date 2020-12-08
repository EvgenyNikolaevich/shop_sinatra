# frozen_string_literal: true

require 'dotenv'
Dotenv.load('.env')

APP_ENV = ENV['RACK_ENV'] || 'development'
