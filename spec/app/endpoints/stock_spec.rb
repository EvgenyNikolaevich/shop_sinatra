# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Endpoints::Stock, type: :request do
  describe 'POST /stocks' do
    let(:json_headers) { { 'CONTENT_TYPE' => 'application/json; charset=utf-8' } }
    let(:id)           { generate(:id).to_s }

    let(:request_body) do
      {
        data: {
          id: id,
          type: 'stocks',
          attributes: {
            bearer_id: generate(:id).to_s,
            name: 'Something'
          }
        }
      }
    end

    subject(:request!) { post '/api/v1/stocks', request_body.to_json, json_headers }

    context 'when request is OK' do
      describe 'response status' do
        it { expect(request!.status).to eq 201 }
        it { expect(request!.body).to include_json(data: { id: id }) }
      end
    end

    context 'when validation is failed' do
      let(:id) { 'ddd' }

      it { expect(request!.status).to eq 400 }
    end

    context 'when stock already exists' do
      before { create :stock, id: id }

      describe 'response status' do
        it { expect(request!.status).to eq 422 }
      end
    end
  end
end
