require 'bundler/setup'
require 'bulwark'

RSpec.describe Bulwark do
  it do
    puts Bulwark.call('zxcv foo@bar.com zxcv')
  end

  describe 'email address detection' do
    File.readlines('spec/fixtures/email.txt').each do |email|
      email.strip!

      it "detects #{email} as email" do
        expect(Bulwark.call(email)).to eq(
          [
            {
              lexeme: :email,
              value: email,
              pos: 0
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
        expect(Bulwark.call(phone_number)).to eq(
          [
            {
              lexeme: :phone,
              value: phone_number,
              pos: 0
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
        expect(Bulwark.call(surname)).to eq(
          [
            {
              lexeme: :surname,
              value: surname,
              pos: 0
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
        expect(Bulwark.call(firstname)).to eq([
          {
            lexeme: :firstname,
            value: firstname,
            pos: 0
          }])
      end
    end
  end

  describe 'multiple matches' do
    it 'matches them all' do
      expect(Bulwark.call(
        '12:34 user=Robert pn=555-123-4567 e=r@example.com'
      )).to eq([
        {type: :firstname},
        {type: :phone},
        {type: :email}
      ])
    end
  end
end
