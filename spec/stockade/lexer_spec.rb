# frozen_string_literal: true

require 'bundler/setup'
require 'stockade'
require 'yaml'

# rubocop:disable Metrics/BlockLength
RSpec.describe Stockade::Lexer do
  Dir.glob('spec/fixtures/*.yaml').each do |file|
    next if file == 'spec/fixtures/contexts.yaml'

    describe file do
      spec = YAML.load_file(file)
      class_name = File.basename(file, '.yaml').capitalize
      lexeme_class = Object.const_get("Stockade::Lexemes::#{class_name}")

      spec.each do |group|
        describe group[:name] do
          group[:good].each do |example|
            example = example.to_s

            it "parses #{example}" do
              expect(Stockade::Lexer.call(example)).to include(
                lexeme_class.new(example)
              )
            end
          end

          (group[:bad] || []).each do |example|
            example = example.to_s

            it "parses #{example}" do
              expect(Stockade::Lexer.call(example)).to_not include(
                lexeme_class.new(example)
              )
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
