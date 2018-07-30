module Stockade
  module Lexemes
    class Phone < Base
      def self.regex
        /
          (?:\+?(\d{1,3}))?
          [-. (]*(\d{3})[-. )]*
          (\d{3})[-. ]*
          (\d{4})
          (?:\s*x(\d+))?
        /x

        /
          \+?
          [\d\(\)\s\-]{6,}
          [\d\(\)\-]
          /x
      end
    end
  end
end
