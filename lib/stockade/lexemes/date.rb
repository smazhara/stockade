# frozen_string_literal: true

module Stockade
  module Lexemes
    # Date lexeme
    class Date < Base
      class << self
        def regex
          /
          (?<!\d)
           (\d{1,4})
            #{delim}
          (\d{1,4})
            #{delim}
          (\d{1,4})
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
            nil
          end
        end.compact
      end

      def parts
        self.class.regex.match(value).captures.map(&:to_i)
      end
    end
  end
end
