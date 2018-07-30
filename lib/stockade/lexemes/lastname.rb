# frozen_string_literal: true

module Stockade
  module Lexemes
    # Lastname lexeme
    class Lastname < Word
      class << self
        def dict_name
          'lastnames'
        end
      end
    end
  end
end
