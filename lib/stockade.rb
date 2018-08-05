# frozen_string_literal: true

require 'memoist'

require 'stockade/version'
require 'stockade/lexer'
require 'stockade/parser'
require 'stockade/lexemes/base'
require 'stockade/lexemes/date'
require 'stockade/lexemes/email'
require 'stockade/lexemes/phone'
require 'stockade/lexemes/dict'
require 'stockade/lexemes/word'
require 'stockade/lexemes/lastname'
require 'stockade/lexemes/firstname'

# Stockade module
module Stockade
  # Mask all PII in `text` with `*`
  #
  def self.mask(text)
    lexemes = Parser.call(Lexer.call(text))
    lexemes.inject(text) do |mask, lexeme|
      prefix = lexeme.start_pos.zero? ? '' : mask[0..lexeme.start_pos - 1]
      postfix = mask[lexeme.end_pos..-1]
      "#{prefix}#{lexeme.mask}#{postfix}"
    end
  end
end
