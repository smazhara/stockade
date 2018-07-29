require 'bloomfilter-rb'
require 'pry-byebug'
require 'memoist'

class Bulwark
  extend Memoist

  attr_reader :datum

  def initialize(datum)
    @datum = datum.strip
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
      word: word_regex,
    }
  end

  def scanner
    StringScanner.new(datum)
  end
  memoize :scanner

  def call
    res = []

    patterns.each do |name, regex|
      scanner.reset

      loop do
        break unless scanner.scan_until(regex)
        value = scanner.matched

        if name == :word
          name = :surname if surname?(value)
          name = :firstname if firstname?(value)
        end

        res << {
          lexeme: name,
          value: scanner.matched,
          pos: scanner.pos
        }
      end
    end

    res
  end

  def word_regex
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
    datum =~ email_regex
  end

  private def phone_number?
    datum =~ phone_number_regex
  end

  private def phone_regex
    /\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*/
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
