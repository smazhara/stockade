# frozen_string_literal: true

require 'credit_card_validations'

module Stockade
  module Lexemes
    # Lexeme for anything that resembles payment card numbers
    # https://en.wikipedia.org/wiki/Payment_card_number
    #
    # Any 10-19 character long sequences of digits optionally grouped using
    # ' ' or '-' delimiters are suspects
    class PaymentCard < Base
      def self.regex
        /
          (?<!\d) # NaN
          \d
          ([\s\-]*\d[\s\-]*){10,17}
          \d
          (?!\d)  # NaN
        /x
      end

      def valid?
        CreditCardValidations::Detector.new(value).valid?
      end
    end
  end
end
