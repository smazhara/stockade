# frozen_string_literal: true

module Stockade
  module Lexemes
    # Word lexeme - abstract class. Used by `Firstname` and `Lastname`.
    class Word < Base
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

      class << self
        extend Memoist

        def dict_name; end

        # rubocop:disable Security/MarshalLoad
        # This is trusted source (see `bin/load`)
        def dict
          return unless dict_name
          Marshal.load(File.read("data/#{dict_name}.dump"))
        end
        # rubocop:enable Security/MarshalLoad
        memoize :dict
      end
    end
  end
end
