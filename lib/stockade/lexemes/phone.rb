# frozen_string_literal: true

module Stockade
  module Lexemes
    # Phone lexeme
    class Phone < Base
      MASKS = File.readlines('data/phones.txt').freeze

      class << self
        def regex
          /
          #{MASKS
            .map { |mask| to_re(mask) }
            .join(" |\n")
          }
          /x
        end

        private

        # Convert less noisy phone mask syntax to regexes
        # ### ### #### => (?:\d{3}\s\d{3}\s\d{4})
        def to_re(mask)
          '(?:' +
            mask
            .gsub('+', '\\\+')
            .gsub(/(#+)/) { |m| "\\d{#{m.size}}" }
            .gsub(' ', '\s')
            .gsub('(', '\(\s*')
            .gsub(')', '\\s*\)') +
            ')'
        end
      end
    end
  end
end
