# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Domains::Stock::Serializers::Stock do
  describe '.serialize' do
    subject(:serialize) { described_class.serialize(entity) }

    let(:entity) { create(:stock) }

    let(:valid_params) do
      {
        data: {
          id: entity.id,
          type: 'stocks',
          attributes: {
            bearer_id: entity.bearer_id,
            name: entity.name,
            created_at: entity.created_at,
            updated_at: entity.updated_at,
            deleted_at: entity.deleted_at
          }
        }
      }.to_json
    end

    it { is_expected.to eq(valid_params) }
  end
end
