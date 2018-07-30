require 'bloomfilter-rb'
require 'memoist'
require 'strscan'
require 'pry-byebug'

module Stockade
  class Lexer
    extend Memoist

    attr_reader :context

    def initialize(context)
      @context = context.strip.dup
    end

    def self.call(context)
      new(context).call
    end

    def lexeme_classes
      [
        Stockade::Lexemes::Date,
        Stockade::Lexemes::Email,
        Stockade::Lexemes::Phone,
        Stockade::Lexemes::Firstname,
        Stockade::Lexemes::Lastname
      ]
    end

    def call
      lexemes = []

      lexeme_classes.each do |lexeme_class|
        scanner = StringScanner.new(context)

        loop do
          break unless scanner.scan_until(lexeme_class.regex)

          lexeme = lexeme_class.new(scanner.matched)

          next unless lexeme.valid?

          lexemes << lexeme
        end
      end

      lexemes
    end
  end
end
