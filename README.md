# PII Lexer

_This is a proof-of-concept level software._

Stockade is a lexer for Personally Identifiable Information (PII). It scans
unstructured text (from files, logs, databases, web etc.) and tokenized
recognized pieces of PII. This information can be used to raise errors,
discard, mask data.

## Installation

```
gem install stockade
```

## Usage

```ruby
require 'stockade'
#=> true
Stockade.mask('Mr. John Smith email is jsmith@example.com')
#=> "Mr. **** ***** email is ******************"
Stockade.mask('and his phone is 555-123-4567.')
#=> *** his phone is ************.
```
Yes, 'and' looks like PII because it's also a lastname, but this should be fixed.

## Implementation

It uses
[StringScanner](https://ruby-doc.org/stdlib-2.5.1/libdoc/strscan/rdoc/StringScanner.html)
and a manually curated list of regular expressions to match strings that _look_
like PII. This works for things like emails, phone numbers, dates, national
ids, credit card numbers and ip addresses. But it does not work for names.
Names are verified against the list of known first and last names that are
stored as a trie.

