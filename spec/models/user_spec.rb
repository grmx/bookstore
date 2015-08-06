require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    describe 'email format' do
      context 'is valid' do
        it do
          should allow_value('a+b@bar.name', 'A_F-OO@b.a.org', 'foo@bar.COM',
            'fst.lst@bar.ua', 'example@from.aero').for(:email)
        end
      end

      context 'is invalid' do
        it { should_not allow_value('example.user@foo.').for(:email) }
        it { should_not allow_value('foo@bar+baz.com').for(:email) }
        it { should_not allow_value('foo@bar_baz.com').for(:email) }
        it { should_not allow_value('user@foo,com').for(:email) }
        it { should_not allow_value('user_at_foo.org').for(:email) }
      end
    end
  end

  describe 'associations' do
    it { should have_many(:identities).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:ratings).dependent(:destroy) }
    it { should have_one(:credit_card).dependent(:destroy) }
  end

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

    context 'user already has identity' do
      it 'returns the user' do
        user.identities.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has no identity' do
      context 'user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
          info: { email: user.email }) }

        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates identity for user' do
          expect { User.find_for_oauth(auth) }.
            to change(user.identities, :count).by(1)
        end

        it 'creates identity with provider and uid' do
          identity = User.find_for_oauth(auth).identities.first

          expect(identity.provider).to eq auth.provider
          expect(identity.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end
    end

    context 'user does not exist' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
        info: { email: 'user@example.dev' }) }

      it 'creates new user' do
        expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
      end

      it 'returns new user' do
        expect(User.find_for_oauth(auth)).to be_a(User)
      end

      it 'fills user email' do
        user = User.find_for_oauth(auth)
        expect(user.email).to eq auth.info.email
      end

      it 'creates identity for user' do
        user = User.find_for_oauth(auth)
        expect(user.identities).to_not be_empty
      end

      it 'creates identity with provider and uid' do
        identity = User.find_for_oauth(auth).identities.first

        expect(identity.provider).to eq auth.provider
        expect(identity.uid).to eq auth.uid
      end
    end
  end
end
