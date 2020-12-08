# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Domains::Stock::Validators::Create do
  let(:params) do
    {
      data: {
        id: generate(:id),
        type: 'stocks',
        attributes: {
          bearer_id: generate(:id),
          name: 'Some original name'
        }
      }
    }
  end

  it_behaves_like 'validator',
                  required_params: %w[
                    data.id
                    data.type
                    data.attributes.bearer_id
                    data.attributes.name
                  ],
                  invalid_params_validation: [
                    { path: 'data.id',                   wrong_value: 'invalid id',   expected_error: 'is in invalid format' },
                    { path: 'data.type',                 wrong_value: '', expected_error: 'must be equal to stocks' },
                    { path: 'data.attributes.bearer_id', wrong_value: 'invalid bearer_id',   expected_error: 'is in invalid format' },
                    { path: 'data.attributes.name',      wrong_value: 'invalid name', expected_error: 'is in invalid format' }
                  ]
end
