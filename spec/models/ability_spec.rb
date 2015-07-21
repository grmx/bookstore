require 'cancan/matchers'
require 'rails_helper'

RSpec.describe Ability, type: :model do
  describe 'abilities of signed in user' do
    subject { ability }
    let(:user){ create(:user) }
    let(:ability){ Ability.new(user) }

    context 'for books' do
      let(:book){ create(:book) }

      it { expect(ability).to be_able_to(:read, book) }

      it { expect(ability).not_to be_able_to(:create, Book) }
      it { expect(ability).not_to be_able_to(:update, book) }
      it { expect(ability).not_to be_able_to(:destroy, book) }
    end

    context 'for categories' do
      let(:category){ create(:category) }

      it { expect(ability).to be_able_to(:read, category) }

      it { expect(ability).not_to be_able_to(:create, Category) }
      it { expect(ability).not_to be_able_to(:update, category) }
      it { expect(ability).not_to be_able_to(:destroy, category) }
    end

    context 'for authors' do
      let(:author){ create(:author) }

      it { expect(ability).to be_able_to(:read, author) }

      it { expect(ability).not_to be_able_to(:create, Author) }
      it { expect(ability).not_to be_able_to(:update, author) }
      it { expect(ability).not_to be_able_to(:destroy, author) }
    end

    context 'for users' do
      it { expect(ability).to be_able_to(:read, user) }

      it { expect(ability).not_to be_able_to(:create, User) }
      it { expect(ability).not_to be_able_to(:update, user) }
      it { expect(ability).not_to be_able_to(:destroy, user) }
    end

  end

  describe 'abilities of signed in administratior' do
    subject { ability }
    let(:admin){ create(:admin) }
    let(:ability){ Ability.new(admin) }

    context 'for books' do
      let(:book){ create(:book) }

      it { expect(ability).to be_able_to(:read, book) }
      it { expect(ability).to be_able_to(:create, Book) }
      it { expect(ability).to be_able_to(:update, book) }
      it { expect(ability).to be_able_to(:destroy, book) }
    end

    context 'for categories' do
      let(:category){ create(:category) }

      it { expect(ability).to be_able_to(:read, category) }
      it { expect(ability).to be_able_to(:create, Category) }
      it { expect(ability).to be_able_to(:update, category) }
      it { expect(ability).to be_able_to(:destroy, category) }
    end

    context 'for authors' do
      let(:author){ create(:author) }

      it { expect(ability).to be_able_to(:read, author) }
      it { expect(ability).to be_able_to(:create, Author) }
      it { expect(ability).to be_able_to(:update, author) }
      it { expect(ability).to be_able_to(:destroy, author) }
    end

    context 'for users' do
      let(:user){ create(:user) }

      it { expect(ability).to be_able_to(:read, user) }
      it { expect(ability).to be_able_to(:create, User) }
      it { expect(ability).to be_able_to(:update, user) }
      it { expect(ability).to be_able_to(:destroy, user) }
    end
  end
end
