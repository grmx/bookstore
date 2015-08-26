require 'rails_helper'

RSpec.describe OrderNotifier, type: :mailer do
  let!(:order) { create(:order_with_items) }
  subject(:order_item) { order.order_items.first }

  describe 'received' do
    let(:mail) { OrderNotifier.received(order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Bookstore Order Confirmation')
      expect(mail.to).to eq([order.user.email])
      expect(mail.from).to eq(['no-reply@bookstore.pp.ua'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to have_content order_item.book.title
      expect(mail.body.encoded).to have_content order_item.book.price
    end
  end

  describe 'shipped' do
    let(:mail) { OrderNotifier.shipped(order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Bookstore Order Shipped')
      expect(mail.to).to eq([order.user.email])
      expect(mail.from).to eq(['no-reply@bookstore.pp.ua'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to have_content order_item.book.title
      expect(mail.body.encoded).to have_content order_item.book.price
    end
  end

end
