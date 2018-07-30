module Stockade
  module Lexemes
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
