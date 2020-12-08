# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Domains::Stock::Repositories::Stock do
  let(:repo)     { described_class.new }
  let(:stocks) { DB[:stocks] }

  describe '#find' do
    let(:id) { generate(:id) }

    subject(:find) { repo.find(id) }

    context 'stock exists' do
      let!(:stock) { create :stock, id: id }

      it { is_expected.to be_an_instance_of(Domains::Stock::Entities::Stock) }
      it { is_expected.to eq(stock) }
    end

    context 'stock does not exist' do
      it { is_expected.to be_nil }
    end
  end

  describe '#create' do
    let(:entity) { build :stock }

    subject(:create_stock) { repo.create(entity) }

    it { expect { create_stock }.to change(stocks, :count).by(1) }
    it { is_expected.to be_an_instance_of(Domains::Stock::Entities::Stock) }
  end

  describe '#exists?' do
    let(:id) { generate :id }

    subject(:exists?) { repo.exists?(id) }

    context 'stock already exists' do
      let!(:stock) { create :stock, id: id }

      it { is_expected.to eq true }
    end

    context 'stock does not exist' do
      it { is_expected.to eq false }
    end
  end

  describe '#update' do
    let(:entity) { create :stock }
    let(:id) { entity.id }
    let(:time) { Time.now.utc }
    let(:deleted_at) { time }

    before do
      entity.deleted_at = time
    end

    subject(:update) { repo.update(entity) }

    it { expect { update }.to change { repo.find(id).deleted_at }.from(nil).to(time) }
  end

  describe '#all' do
    let!(:entities) { create_list :stock, 2 }

    subject(:all) { repo.all }

    it { is_expected.to match_array(entities) }
  end
end
