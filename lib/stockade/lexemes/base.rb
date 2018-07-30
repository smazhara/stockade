# frozen_string_literal: true

module Stockade
  module Lexemes
    # Base class for all lexemes
    #
    # Lexer extracts lexem candidates of text using `.regex` of
    # corresponding= subclass, instantiates it and then furtner calls
    # its `#valid?` to verify that this is indeed a valid lexeme.
    #
    class Base
      attr_reader :value

      def initialize(value)
        @value = value.downcase.strip
      end

      def self.regex; end

      def valid?
        true
      end

      def ==(other)
        value == other.value &&
          self.class == other.class
      end
    end
  end
end
