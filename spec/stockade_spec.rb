# frozen_string_literal: true

require 'stockade'

RSpec.describe Stockade do
  describe '.mask' do
    yaml = YAML.load_file('spec/fixtures/contexts.yaml')

    yaml.each do |spec|
      describe spec[:name] do
        spec[:examples].each_slice(2) do |input, output|
          it "masks '#{input}'" do
            expect(Stockade.mask(input)).to eq(output)
          end
        end
      end
    end
  end
end
