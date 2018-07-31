# frozen_string_literal: true

module Stockade
  module Lexemes
    # Date lexeme
    class Date < Base
      class << self
        def regex
          /
          (?<!\d)
           (\d{1,2})
            #{delim}
          (\d{1,2})
            #{delim}
          ((?:19|20)\d{1,2})
          (?!\d)
          /x
        end

        def delim
          %r{[\s\.\-\/]}
        end
      end

      def valid?
        possible_dates.any? &&
        possible_dates.all? do |date|
          date <= ::Date.today
        end
      end

      private

      def possible_dates
        parts.permutation.map do |permutation|
          begin
            ::Date.new(*permutation)
          rescue ArgumentError
          end
        end.compact
      end

      def parts
        self.class.regex.match(value)[1..-1].map(&:to_i)
      end
    end
  end
end
