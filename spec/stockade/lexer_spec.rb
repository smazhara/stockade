require 'bundler/setup'
require 'stockade'

RSpec.describe Stockade::Lexer do
  it do
    Stockade::Lexer.call('zxcv foo@bar.com zxcv')
  end

  describe 'email address detection' do
    File.readlines('spec/fixtures/email.txt').each do |email|
      email.strip!

      it "detects #{email} as email" do
        expect(Stockade::Lexer.call(email)).to eq(
          [
            {
              lexeme: :email,
              value: email
            }
          ]
        )
      end
    end
  end

  describe 'phone number detection' do
    File.readlines('spec/fixtures/phone_numbers.txt').each do |phone_number|
      phone_number.strip!

      it "detects '#{phone_number}' as phone number" do
        expect(Stockade::Lexer.call(phone_number)).to eq(
          [
            {
              lexeme: :phone,
              value: phone_number
            }
          ]
        )
      end
    end
  end

  describe 'surname detection' do
    File.readlines('spec/fixtures/surnames.txt').each do |surname|
      surname.strip!

      it "detects '#{surname}' as a surname" do
        expect(Stockade::Lexer.call(surname)).to eq(
          [
            {
              lexeme: :surname,
              value: surname
            }
          ]
        )
      end
    end
  end

  describe 'firstname detection' do
    File.readlines('spec/fixtures/firstnames.txt').each do |firstname|
      firstname.strip!

      it "detects '#{firstname}' as a firstname" do
        expect(Stockade::Lexer.call(firstname)).to eq([
          {
            lexeme: :firstname,
            value: firstname
          }])
      end
    end
  end

  describe 'multiple matches' do
    it 'matches them all' do
      expect(Stockade::Lexer.call(
        '12:34 user=Robert pn=555-123-4567 e=r@example.com l=Zwolak'
      )).to eq([
        {
          lexeme: :email,
          value: 'r@example.com'
        },
        {
          lexeme: :phone,
          value: '555-123-4567'
        },
        {
          lexeme: :firstname,
          value: 'Robert'
        },
        {
          lexeme: :surname,
          value: 'Zwolak'
        }
      ])
    end
  end
end
