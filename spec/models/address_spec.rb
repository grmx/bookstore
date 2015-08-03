require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:phone) }
    it { should validate_length_of(:zipcode).is_equal_to(5) }
    it { should validate_length_of(:phone).is_at_least(5).is_at_most(12) }
  end

  describe '#full_name' do
    let(:address) { create(:address) }

    it 'returns a full name' do
      expect(address.full_name).to eq "#{address.first_name} #{address.last_name}"
    end
  end
end
