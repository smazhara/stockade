module Stockade
  module Lexemes
    class Lastname < Word
      class << self
        def dict_name
          'lastnames'
        end
      end
    end
  end
end
