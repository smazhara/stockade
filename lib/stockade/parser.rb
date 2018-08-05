# frozen_string_literal: true

module Stockade
  # Parser
  #
  # Takes a raw list (a set really) of lexemes returned by Lexer
  # and further processes them. Currently this means:
  # 1. Deduping - >1 ambiguous lexemes matching exactly same fragment
  #    are deduped according to their priority. Only the highest priority
  #    lexeme kept.
  # 2. Removing covered lexems - lexeme that matches a string that is a
  # substring of another matched string is removed.
  #
  class Parser
    extend Memoist

    attr_reader :lexemes

    def initialize(lexemes)
      @lexemes = lexemes
    end

    def self.call(lexemes)
      new(lexemes).call
    end

    def call
      non_covered_lexemes
    end

    private

    def grouped
      lexemes.group_by(&:range).values
    end
    memoize :grouped

    def deduped
      grouped.map do |group|
        if group.size == 1
          group.first
        else
          group.max_by do |lexeme|
            priority(lexeme)
          end
        end
      end
    end
    memoize :deduped

    def ordered
      lexemes.sort_by(&:start_pos)
    end
    memoize :ordered

    def non_covered_lexemes
      res = deduped.dup

      res.each_index do |index|
        head, *rest = *res[index..-1]

        rest.each do |lex|
          next unless covers?(head, lex)
          res.delete(lex)
        end
      end.to_a

      res
    end

    def covers?(head, lex)
      head != lex &&
        head.start_pos <= lex.start_pos &&
        head.end_pos >= lex.end_pos
    end

    def priority(lexeme)
      lexeme_priorities.index(lexeme.class)
    end

    def lexeme_priorities
      [
        Lexemes::Word,
        Lexemes::Firstname,
        Lexemes::Lastname,
        Lexemes::Phone,
        Lexemes::Date,
        Lexemes::Email
      ]
    end
  end
end
