require 'bloomfilter-rb'
require 'pry-byebug'
require 'memoist'

class Bulwark
  extend Memoist

  attr_reader :datum

  def initialize(datum)
    @datum = datum.strip.dup
  end

  def self.call(datum)
    new(datum).call
  end

  # order is important - from most specific to least
  # the first one that matches stops the scan
  def patterns
    {
      email: email_regex,
      phone: phone_regex,
      name: name_regex,
    }
  end

  def scanner
    StringScanner.new(datum)
  end
  memoize :scanner

  def call
    res = []

    patterns.each do |name, regex|
      scanner = StringScanner.new(datum)

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

        @datum = @datum[0..scanner.pos-scanner.matched.size] +
          '*' * scanner.matched.size +
          @datum[scanner.pos..-1]
      end
    end

    res
  end

  def name_regex
    /\w+/
  end

  def word_regex
    /\W+/
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
    datum =~ email_regex
  end

  private def phone_number?
    datum =~ phone_number_regex
  end

  private def phone_regex
    /\b(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\b/
  end

  private def surname?(value)
    found?('surnames', value)
  end

  private def firstname?(value)
    found?('firstnames', value)
  end

  private def found?(db, value)
    db(db).include?(value.downcase)
  end

  private def db(name)
    Marshal.load(File.read("data/#{name}.dump"))
  end
  memoize :db
end
