[![Test Coverage](https://api.codeclimate.com/v1/badges/a99a88d28ad37a79dbf6/test_coverage)](https://codeclimate.com/github/codeclimate/codeclimate/test_coverage)

# PII Detector

_This is a proof-of-concept level software._

Stockade is a Personally Identifiable Information (PII) detector. It scans
unstructured text (from files, logs, databases, web etc.) and masks all
identified pieces of PII.

## Installation

```
gem install stockade
```

## Usage

```ruby
require 'stockade'

puts Stockade.mask(<<-EOS

Dossier on Mr. John Smith born 09/02/1995
His email is jsmith@example.com and his phone is 555-123-4567.
He is using Visa card 4111 1111 1111 1111

EOS

#=>
Dossier on Mr. **** ***** born **********
His email is ****************** and his phone is ************.
** is using Visa card *******************

```
Notice, how word 'He' was incorrectly identified as a name.

## Implementation

This is done in three stages.

### Scanning

Using a manually curated list of regexes and
[StringScanner](https://ruby-doc.org/stdlib-2.5.1/libdoc/strscan/rdoc/StringScanner.html)
it extracts and labels lexeme candidates.

### Evaluation

Lexeme candidates further evaluated (in some cases this is a no-op) to filter
out false positives.  For example, first and lastnames are checked against a
database of known names. Dates are checked to be in the past.

### Parsing

Some rudimentary parsing done. Lexemes that are fully covered by other lexemes
are eliminated. Ambiguous lexemes are disambiguated using rules of precedence.
