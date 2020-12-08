# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Domains::Stock::Entities::Stock do
  describe '#wrap' do
    let(:hash) do
      {
        id: generate(:id),
        bearer_id: generate(:id),
        created_at: Time.now,
        updated_at: Time.now,
        deleted_at: nil
      }
    end

    subject(:wrap) { described_class.wrap hash }

    it { is_expected.to be_an_instance_of described_class }
  end
end
