# PII Lexer

_This is a proof-of-concept level software._

Stockade is a lexer for Personally Identifiable Information (PII). It scans unstructured text (from files, logs, databases,
web etc.) and tokenized recognized pieces of PII. This information can be used to raise errors, discard, mask data.

## Installation

```
gem install stockade
```

## Usage

```ruby
irb(main):001:0> require 'stockade'
=> true
irb(main):002:0> lexer = Stockade::Lexer.new('12:34 user=Robert pn=555-123-4567 e=r@example.com l=Zwolak')
=> #<Stockade::Lexer:0x007faf243b03a0 @context="12:34 user=Robert pn=555-123-4567 e=r@example.com l=Zwolak">
irb(main):003:0> lexer.call
=> [{:lexeme=>:email, :value=>"r@example.com"}, {:lexeme=>:phone, :value=>"555-123-4567"}, {:lexeme=>:firstname, :value=>"Robert"}, {:lexeme=>:surname, :value=>"Zwolak"}]
```

## Implementation

It uses [StringScanner](https://ruby-doc.org/stdlib-2.5.1/libdoc/strscan/rdoc/StringScanner.html) and a manually curated list of regular expressions to match strings that _look_ like PII. This works for things like emails, phone numbers, dates, national ids, credit card numbers and ip addresses. But it does not work for names. Names are verified against the list of known first and last names that are stored as a (Bloom Filter)[https://en.wikipedia.org/wiki/Bloom_filter].

