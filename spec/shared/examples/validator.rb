# frozen_string_literal: true

RSpec.shared_examples 'validator' do |**options|
  shared_examples 'has error' do |message, path|
    it 'failed' do
      is_expected.not_to be_success
    end

    it "return error message `#{message}` at: `#{path.join(', ')}`" do
      errors =
        path.reduce(subject.errors.to_h) do |result, key|
          next result[key] if result.key?(key)

          next result.values.first[key] if result.keys.first.is_a?(Integer)
        end

      expect(errors).to include match(message)
    end
  end

  shared_examples 'has required param' do |param, path = []|
    context "without :#{param} at #{path.empty? ? 'root' : path.join('.')}" do
      before do
        path
          .reduce(params) { |result, key| result[key].is_a?(Array) ? result[key].sample : result[key] }
          .delete(param)
      end

      it_behaves_like 'has error', 'is missing', [*path, param]
    end
  end

  describe '.validate' do
    subject(:validate) { described_class.validate params }

    context 'with valid data' do
      it { is_expected.to be_success }
    end

    context 'without required attribute' do
      options[:required_params].each do |required_param|
        *path, param = required_param.split('.').map(&:to_sym)

        it_behaves_like 'has required param', param, path
      end
    end

    context 'with invalid params' do
      options[:invalid_params_validation].each do |**invalid_param_options|
        *path, last_key = invalid_param_options[:path].split('.').map(&:to_sym)
        wrong_value     = invalid_param_options[:wrong_value]
        expected_error  = invalid_param_options[:expected_error]

        context "when #{last_key} is invalid" do
          before do
            last_hash =
              path.reduce(params) do |result, key|
                next (result[key] ||= {}) unless result[key].is_a?(Array)

                result[key].sample ||= {}
              end

            last_hash[last_key] = wrong_value
          end

          it_behaves_like 'has error', expected_error, [*path, last_key]
        end
      end
    end
  end
end
