# frozen_string_literal: true

require 'stockade'

# rubocop:disable Metrics/BlockLength
RSpec.describe Stockade::Parser do
  subject do
    Stockade::Parser.call(lexemes)
  end

  # Make helper methods like this
  # def foo(value, pos)
  #   Stockade::Lexemes::Foo.new(value, pos)
  # end
  %w[date email firstname lastname phone word].each do |type|
    define_method type do |value, position|
      Module
        .const_get("Stockade::Lexemes::#{type.capitalize}")
        .new(value, position)
    end
  end

  context 'when empty' do
    let(:lexemes) { [] }

    it { should eq lexemes }
  end

  context 'when two non-overlapping lexemes' do
    let :lexemes do
      [
        email('foo@bar.com', 1),
        word('foo', 20)
      ]
    end

    it { should eq lexemes }
  end

  context 'when one lexeme is included in another' do
    let(:outer) { email('foo@bar.com', 1) }

    let(:inner) { word('foo', 1) }

    let(:lexemes) { [outer, inner] }

    it 'deletes the included lexemes because it is redundant' do
      should eq [outer]
    end
  end

  context 'when one lexeme only partially included in another' do
    let(:outer) { email('foo@bar.com', 1) }

    let(:overlapping) { word('comfoo', 9) }

    let(:lexemes) { [outer, overlapping] }

    it 'does not delete it' do
      should eq [outer, overlapping]
    end
  end

  context 'when deeply nested lexemes' do
    let(:outer) { email('mr.johnson@example.com', 5) }

    let(:mid) { lastname('johnson', 8) }

    let(:inner) { firstname('john', 9) }

    let(:lexemes) { [outer, mid, inner] }

    it 'leaves only outermost lexeme' do
      should eq [outer]
    end
  end
end
# rubocop:enable Metrics/BlockLength
