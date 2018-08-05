# frozen_string_literal: true

module Stockade
  module Lexemes
    # Phone lexeme
    class Phone < Base
      # Less noisy phone mask syntax compared to regexes
      MASKS = [
        '###-###-####',
        '### ### ####',
        '(## ##) #### ####',
        '##########',
        '(##) #### ####',
        '(##) ## #### ####',
        '###-###-###-####',
        '#-###-###-####',
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
          Regexp.new(
            '(?:' +
            mask
              .gsub(/^#/, '\D*\d')
              .gsub(/#/, '\d')
              .gsub(/\s/, '\s')
              .gsub(/\(/, '\(\s*')
              .gsub(/\)/, '\\s*\)') +
            ')'
          )
        end
      end
    end
  end
end
