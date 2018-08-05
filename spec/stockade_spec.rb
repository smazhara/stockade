# frozen_string_literal: true

require 'stockade'

RSpec.describe Stockade do
  describe '.mask' do
    it 'greedily masks everything that looks like pii' do
      expect(Stockade.mask('
        Dossier on Mr. John Stevenson DOB 1969-12-02
        personal email jstevenson@example.com and
        private phone number (555) 123-9488
      ')).to eq('
        Dossier ** Mr. **** ********* DOB **********
        personal email ********************** ***
        ******* phone ****** **************
      ')
    end
  end
end
