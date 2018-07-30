# frozen_string_literal: true

module Stockade
  module Lexemes
    # Date lexeme
    class Date < Base
      class << self
        def regex
          /
          (?:
            \d{1,2}
            #{delim}
            \d{1,2}
            #{delim}
            \d{4}
          )
          /x
        end

        def delim
          %r{[\s\.\-\/]}
        end
      end

      def valid?
        true
      end
    end
  end
end
