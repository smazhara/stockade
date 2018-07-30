# frozen_string_literal: true

module Stockade
  module Lexemes
    # Firstname lexeme
    class Firstname < Word
      class << self
        def dict_name
          'firstnames'
        end
      end
    end
  end
end
