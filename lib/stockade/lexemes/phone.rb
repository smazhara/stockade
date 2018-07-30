# frozen_string_literal: true

module Stockade
  module Lexemes
    # PHone lexeme
    class Phone < Base
      def self.regex
        /
          \+?
          [\d\(\)\s\-]{6,}
          [\d\(\)\-]
          /x
      end
    end
  end
end
