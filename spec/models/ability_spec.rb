require 'cancan/matchers'
require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject { ability }
  let(:ability){ Ability.new(user) }

  describe 'abilities of guest' do
    let(:user){ nil }

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

    context 'for customers' do
      let(:customer) { create(:user) }

      it { expect(ability).not_to be_able_to(:read, customer) }
      it { expect(ability).not_to be_able_to(:create, User) }
      it { expect(ability).not_to be_able_to(:update, customer) }
      it { expect(ability).not_to be_able_to(:destroy, customer) }
    end

    context 'for ratings' do
      let(:rating) { create(:rating) }

      it { expect(ability).to be_able_to(:read, rating) }
      it { expect(ability).not_to be_able_to(:create, Rating) }
      it { expect(ability).not_to be_able_to(:update, rating) }
      it { expect(ability).not_to be_able_to(:destroy, rating) }
    end

    context 'for orders' do
      let(:order) { create(:order) }

      it { expect(ability).not_to be_able_to(:read, order) }
      it { expect(ability).not_to be_able_to(:create, Order) }
      it { expect(ability).not_to be_able_to(:update, order) }
      it { expect(ability).not_to be_able_to(:destroy, order) }
    end

    context 'for order items' do
      let(:order_item) { create(:order_item) }

      it { expect(ability).not_to be_able_to(:read, order_item) }
      it { expect(ability).not_to be_able_to(:create, OrderItem) }
      it { expect(ability).not_to be_able_to(:update, order_item) }
      it { expect(ability).not_to be_able_to(:destroy, order_item) }
    end
  end

  describe 'abilities of signed in user' do
    let(:user){ create(:user) }

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

    context 'for ratings' do
      let(:rating) { create(:rating, user: user) }

      it { expect(ability).to be_able_to(:read, rating) }
      it { expect(ability).to be_able_to(:create, Rating) }
      it { expect(ability).to be_able_to(:update, rating, user: user) }
      it { expect(ability).not_to be_able_to(:destroy, rating) }
    end

    context 'for orders' do
      let(:order) { create(:order, user: user) }

      it { expect(ability).to be_able_to(:read, order, user: user) }
      it { expect(ability).to be_able_to(:create, Order, user: user) }
      it { expect(ability).to be_able_to(:update, order, user: user) }
      it { expect(ability).to be_able_to(:destroy, order, user: user) }
    end

    context 'for order items' do
      let(:order) { create(:order, user: user) }
      let(:order_item) { create(:order_item, order: order) }

      it { expect(ability).to be_able_to(:read, order_item, user: user) }
      it { expect(ability).to be_able_to(:create, OrderItem, user: user) }
      it { expect(ability).to be_able_to(:update, order_item, user: user) }
      it { expect(ability).to be_able_to(:destroy, order_item, user: user) }
    end
  end

  describe 'abilities of signed in administratior' do
    let(:user){ create(:admin) }

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
      let(:customer){ create(:user) }

      it { expect(ability).to be_able_to(:read, customer) }
      it { expect(ability).to be_able_to(:create, User) }
      it { expect(ability).to be_able_to(:update, customer) }
      it { expect(ability).to be_able_to(:destroy, customer) }
    end

    context 'for ratings' do
      let(:rating) { create(:rating) }

      it { expect(ability).to be_able_to(:read, rating) }
      it { expect(ability).to be_able_to(:create, Rating) }
      it { expect(ability).to be_able_to(:update, rating) }
      it { expect(ability).to be_able_to(:destroy, rating) }
    end

    context 'for orders' do
      let(:order) { create(:order) }

      it { expect(ability).to be_able_to(:read, order) }
      it { expect(ability).to be_able_to(:create, Order) }
      it { expect(ability).to be_able_to(:update, order) }
      it { expect(ability).to be_able_to(:destroy, order) }
    end

    context 'for order items' do
      let(:order_item) { create(:order_item) }

      it { expect(ability).to be_able_to(:read, order_item) }
      it { expect(ability).to be_able_to(:create, OrderItem) }
      it { expect(ability).to be_able_to(:update, order_item) }
      it { expect(ability).to be_able_to(:destroy, order_item) }
    end

  end
end
