# frozen_string_literal: true

module Endpoints
  class Stock < Sinatra::Base
    helpers Helpers::Endpoints

    set :show_exceptions, false
    set :raise_errors, true

    post '/stocks', provides: :json do
      submit! Domains::Stock::Forms::Create.new(params) do |form|
        check! form.result do
          status 201

          Domains::Stock::Serializers::Stock.serialize(form.result.data).to_json
        end
      end
    end

    put '/stocks', provides: :json do
      submit! Domains::Stock::Forms::Update.new(params) do |form|
        check! form.result do
          status 200

          Domains::Stock::Serializers::Stock.serialize(form.result.data).to_json
        end
      end
    end

    get '/stocks', provides: :json do
      check! Domains::Stock::Sequences::GetAll.call do |result|
        status 200

        Domains::Stock::Serializers::Stock.serialize(result.data, is_collection: true).to_json
      end
    end

    delete '/stocks/:id' do
      # never met this before
      params[:id].slice!(':')

      check! Domains::Stock::Sequences::Delete.call(id: params[:id]) do
        status 200
      end
    end
  end
end
