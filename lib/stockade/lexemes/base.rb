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
      attr_reader :raw_value, :start_pos

      def initialize(value, start_pos = nil)
        @raw_value = value
        @start_pos = start_pos
      end

      def value
        raw_value.downcase.strip
      end

      def end_pos
        start_pos + raw_value.size
      end

      def self.regex; end

      def valid?
        true
      end

      def ==(other)
        value == other.value &&
          self.class == other.class
      end

      def range
        start_pos..end_pos
      end

      def mask
        '*' * raw_value.size
      end
    end
  end
end
