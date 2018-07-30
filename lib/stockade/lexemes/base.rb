module Stockade
  module Lexemes
    class Base
      attr_reader :value

      def initialize(value)
        @value = value.downcase.strip
      end

      def self.regex
      end

      def valid?
        true
      end

      def ==(other)
        self.value == other.value &&
          self.class == other.class
      end
    end
  end
end
