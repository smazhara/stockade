# frozen_string_literal: true

module Stockade
  module Lexemes
    # Email lexeme
    class Email < Base
      def self.regex
        /
        [\w+\-\.\+]+
        @
        [a-z\d\-]+
        (\.[a-z]+)*
        \.[a-z]+ # TLD
        /x
      end
    end
  end
end
