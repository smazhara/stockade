# frozen_string_literal: true

require 'stockade'

# rubocop:disable Metrics/BlockLength
RSpec.describe Stockade do
  describe '.mask' do
    it "paranoidally masks everything that looks like pii
      notice how it masks 'private', 'number', and 'and'.
      Apparently those are valid lastnames.
    " do
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

    it do
      expect(Stockade.mask(
               'Mr. John Smith email is jsmith@example.com'
             )).to eq(
               'Mr. **** ***** email is ******************'
             )
    end

    it do
      expect(Stockade.mask(
               'and his phone is 555-123-4567.'
             )).to eq(
               '*** his phone is ************.'
             )
    end
  end
end
# rubocop:enable Metrics/BlockLength
