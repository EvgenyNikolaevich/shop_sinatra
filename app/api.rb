# frozen_string_literal: true

require 'sinatra/base'

class Api < Sinatra::Base
  use Endpoints::Health
  use Endpoints::Stock
end
