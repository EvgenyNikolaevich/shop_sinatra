# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Domains::Stock::Mappers::Stock do
  include_examples 'mapper', for_table: :stocks do
    let(:entity) { build :stock, :stub }
  end
end
