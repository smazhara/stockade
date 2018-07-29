require 'stockade/version'

require 'bloomfilter-rb'
require 'memoist'
require 'strscan'

module Stockade
  class Lexer
    extend Memoist

    attr_reader :context

    def initialize(context)
      @context = context.strip.dup
    end

    def self.call(context)
      new(context).call
    end

    def patterns
      {
        email: email_regex,
        phone: phone_regex,
        name: name_regex,
      }
    end

    def call
      res = []

      patterns.each do |name, regex|
        scanner = StringScanner.new(context)

        loop do
          break unless scanner.scan_until(regex)
          value = scanner.matched

          lexeme = name
          if lexeme == :name
            lexeme = :surname if surname?(value)
            lexeme = :firstname if firstname?(value)
          end
          next if lexeme == :name

          res << {
            lexeme: lexeme,
            value: scanner.matched
          }

          @context = @context[0..scanner.pos-scanner.matched.size] +
            '*' * scanner.matched.size +
            @context[scanner.pos..-1]
        end
      end

      res
    end

    def name_regex
      /\w+/
    end

    private def email_regex
      /
      [\w+\-\.\+]+
        @
        [a-z\d\-]+
        (\.[a-z]+)*
        \.[a-z]+ # TLD
        /x
    end

    private def email_address?
      context =~ email_regex
    end

    private def phone_number?
      context =~ phone_number_regex
    end

    private def phone_regex
      /
        (?:\+?(\d{1,3}))?
        [-. (]*(\d{3})[-. )]*
        (\d{3})[-. ]*
        (\d{4})
        (?:\s*x(\d+))?
      /x
    end

    private def surname?(value)
      found?('surnames', value)
    end

    private def firstname?(value)
      found?('firstnames', value)
    end

    private def found?(db, value)
      self.class.db(db).include?(value.downcase)
    end

    class << self
      extend Memoist

      def db(name)
        Marshal.load(File.read("data/#{name}.dump"))
      end
      memoize :db
    end
  end
end
