require 'bundler/setup'
require 'stockade'
require 'yaml'

RSpec.describe Stockade::Lexer do
  Dir.glob('spec/fixtures/*.yaml').each do |file|
    puts file
    spec = YAML.load_file(file)

    context spec[:name] do
      spec[:examples].each do |example|
        it "parses '#{example[:input]}'" do
          expect(Stockade::Lexer.call(example[:input])).to eq(example[:output])
        end
      end
    end
  end
end
