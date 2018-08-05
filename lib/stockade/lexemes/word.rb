# frozen_string_literal: true

module Stockade
  module Lexemes
    # A word found is common words dictionary
    class Word < Dict
      def self.dict_name
        'words'
      end

      # common dictionary words are safe
      def mask
        raw_value
      end
    end
  end
end
