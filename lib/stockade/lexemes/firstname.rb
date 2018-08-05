# frozen_string_literal: true

module Stockade
  module Lexemes
    # Firstname lexeme
    class Firstname < Dict
      class << self
        def dict_name
          'firstnames'
        end
      end
    end
  end
end
