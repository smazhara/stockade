require 'bundler/setup'
require 'stockade'
require 'yaml'

RSpec.describe Stockade::Lexer do
  describe "complete contexts" do
    spec = YAML.load_file('spec/fixtures/contexts.yaml')

    context spec[:name] do
      spec[:examples].each do |example|
        it "parses '#{example[:input]}'" do
          expect(Stockade::Lexer.call(example[:input]))
            .to eq(
              example[:output].map do |spec|
                class_name = spec[:lexeme].to_s.capitalize
                Object.const_get("Stockade::Lexemes::#{class_name}")
                  .new(spec[:value])
              end
          )
        end
      end
    end
  end

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
