# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Endpoints::Health, type: :request do
  describe 'GET /health' do
    subject(:request!) { get '/api/v1/health' }

    context 'on disable connection' do
      before do
        allow(DB).to receive(:test_connection).and_raise(Sequel::Error)
      end

      it 'return 500' do
        request!
        expect(last_response.status).to eq(500)
      end
    end

    context 'on enabled connection' do
      it 'return 200' do
        request!
        expect(last_response.status).to eq(200)
      end
    end
  end
end
