# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Domains::Stock::Sequences::Create do
  subject(:call) { described_class.call(id: id, name: name, bearer_id: bearer_id) }

  let(:id)        { generate(:id) }
  let(:name)      { 'Goods #1' }
  let(:bearer_id) { generate(:id) }

  before do
    allow_any_instance_of(Domains::Stock::Repositories::Stock).to receive(:exists?).and_return stock_exists?
  end

  describe '.call' do
    context 'when stock already exists' do
      let(:stock_exists?) { true }

      it { is_expected.to be_failed }
    end

    context 'when everything ok' do
      let(:stock_exists?) { false }
      let(:stock)         { build :stock }

      before do
        allow_any_instance_of(Domains::Stock::Repositories::Stock).to receive(:create).and_return stock
      end

      it { is_expected.to be_success }
    end
  end
end
