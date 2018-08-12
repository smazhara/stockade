# frozen_string_literal: true

require 'rambling-trie'
require 'memoist'
require 'strscan'
require 'pry-byebug'

module Stockade
  # Class Lexer
  #
  # Usage `Stockade::Lexer.call(context)`
  #
  # Returns list of found lexemes.
  #
  class Lexer
    extend Memoist

    attr_reader :context

    def initialize(context)
      @context = context.dup
    end

    def self.call(context)
      new(context).call
    end

    def lexeme_classes
      [
        Stockade::Lexemes::PaymentCard,
        Stockade::Lexemes::Date,
        Stockade::Lexemes::Email,
        Stockade::Lexemes::Phone,
        Stockade::Lexemes::Word,
        Stockade::Lexemes::Firstname,
        Stockade::Lexemes::Lastname
      ]
    end

    def call
      lexeme_classes.map do |lexeme_class|
        tokenize(lexeme_class)
      end.flatten
    end

    private

    def tokenize(lexeme_class)
      lexemes = []
      scanner = StringScanner.new(context)

      while scanner.scan_until(lexeme_class.regex)
        lexemes << lexeme_class.new(
          scanner.matched,
          scanner.pos - scanner.matched.size
        )
      end

      lexemes.select(&:valid?)
    end
  end
end
