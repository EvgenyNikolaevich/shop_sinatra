# frozen_string_literal: true

RSpec.shared_examples 'mapper' do |mapper = described_class, for_table:|
  context 'when comparing with DB,' do
    let(:schema)     { DB.schema(for_table) }
    let(:columns)    { schema.map(&:first) }
    let(:sample_row) { columns.each_with_object({}) { |column, h| h[column] = column.to_s } }

    let(:mapped_attrs) { mapper.from_row(sample_row) }
    let(:remapped_row) { mapper.to_row(mapped_attrs) }

    it 'can map Actual `row` to `attrs` and vice-versa' do
      expect(sample_row).to eq remapped_row
    end
  end

  context 'when comparing with Entity,' do
    let(:mapped_row)      { mapper.to_row(entity) }
    let(:remapped_attrs)  { mapper.from_row(mapped_row) }
    let(:rebuilt_entity)  { entity.class.wrap(remapped_attrs) }
    let(:attributes_list) { entity.class.serializable_attributes_list }

    it 'let(:entity) has all attributes defined (self-check)' do
      missed_attrs = attributes_list.select { |k| entity.public_send(k).nil? }

      expect(missed_attrs).to be_empty, 'expected `let(:entity)` to has all attributes filled,' \
        " but attrs `#{missed_attrs.join(', ')}` return nil"
    end

    it 'can map Actual `attrs` to `row` and vice-versa' do
      entity.extend         LunaPark::Extensions::ComparableDebug
      rebuilt_entity.extend LunaPark::Extensions::ComparableDebug

      detailed_differences = entity.detailed_differences(rebuilt_entity)

      # same as `expect(entity).to eq rebuilt_entity` but with custom message
      expect(detailed_differences).to be_empty, 'expected `entity` to eq `rebuilt_entity`, but got differences:' \
        " #{detailed_differences}"
    end
  end
end
