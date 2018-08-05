# frozen_string_literal: true

module Stockade
  module Lexemes
    # Abstract Dictionary lexeme
    #
    # Dictionary lexemes are those that can only be verified by
    # checking the corresponding dictionary
    #
    class Dict < Base
      def self.regex
        /
          [a-zA-Z]+
        /x
      end

      def valid?
        return false unless self.class.dict
        self.class.dict.include?(value)
      end

      def name
        raise 'Abstract'
      end

      def common_word?
        Word.new(value: value).valid?
      end

      class << self
        extend Memoist

        def dict_name; end

        def dict
          Rambling::Trie.load("data/#{dict_name}.dump")
        end
        memoize :dict
      end
    end
  end
end
