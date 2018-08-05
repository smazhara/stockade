# frozen_string_literal: true

module Stockade
  module Lexemes
    # Phone lexeme
    class Phone < Base
      # Less noisy phone mask syntax compared to regexes
      MASKS = [
        '#-###-###-####',
        '+#-###-###-####',
        '+##-###-###-####',
        '+###-###-###-####',
        '###-###-####',
        '### ### ####',
        '(## ##) #### ####',
        '##########',
        '(##) #### ####',
        '(##) ## #### ####',
        '###-###-###-####',
        '###-####',
        '(###) ###-####'
      ].freeze

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

        # Convert phone number mask to its regex
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
