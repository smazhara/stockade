module Stockade
  module Lexemes
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

        def dict
          return unless dict_name
          Marshal.load(File.read("data/#{dict_name}.dump"))
        end
        memoize :dict
      end
    end
  end
end
