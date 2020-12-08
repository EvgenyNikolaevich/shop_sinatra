# frozen_string_literal: true

require 'zeitwerk'

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
require_relative 'environment'
require_relative 'root'
require_relative 'config'
Bundler.require(:default, APP_ENV)

loader = Zeitwerk::Loader.new # root: APP_ROOT
loader.preload 'config/initializers'
loader.preload 'lib/rack'
loader.push_dir('app')
loader.setup # ready!
