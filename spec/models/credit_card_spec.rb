require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:exp_month) }
    it { should validate_presence_of(:exp_year) }
    it { should validate_presence_of(:cvv) }
    it { should validate_length_of(:number).is_equal_to(16) }
    it { should validate_length_of(:exp_month).is_at_most(2) }
    it { should validate_length_of(:exp_year).is_equal_to(4) }
    it { should validate_length_of(:cvv).is_equal_to(3) }
  end

  describe 'association' do
    it { should belong_to(:user) }
  end

  describe 'additional methods' do
    let(:credit_card) { create(:credit_card) }

    describe '#last_digits' do
      subject(:subject) { credit_card.last_digits }

      it 'returns four symbols' do
        expect(subject.size).to eq 4
      end

      it 'returns last four digits' do
        expect(subject).to eq credit_card.number[-4..-1]
      end
    end

    describe '#mask' do
      it 'returns last digest with hidden symobls' do
        expect(credit_card.mask).to eq "**** **** **** #{credit_card.last_digits}"
      end
    end

    describe '#date' do
      it 'returns an expiration date' do
        expect(credit_card.date).to eq '2/2017'
      end
    end
  end
end
