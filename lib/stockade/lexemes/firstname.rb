module Stockade
  module Lexemes
    class Firstname < Word
      class << self
        def dict_name
          'firstnames'
        end
      end
    end
  end
end
