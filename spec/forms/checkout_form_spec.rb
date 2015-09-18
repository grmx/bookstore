require 'rails_helper'

RSpec.describe CheckoutForm do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }
  subject { CheckoutForm.new(order) }

  it { expect(subject).to respond_to(:billing_address) }
  it { expect(subject).to respond_to(:shipping_address) }
  it { expect(subject).to respond_to(:deliveries) }
  it { expect(subject).to respond_to(:payment) }
  it { expect(subject).to respond_to(:save) }

  describe '#save_billing_address' do
    let(:address) { attributes_for(:address) }

    context 'creates a new billing address' do
      before do
        subject.save_billing_address(address)
      end

      it 'saves attributes' do
        expect(subject.billing_address.first_name).to eq address[:first_name]
        expect(subject.billing_address.address).to eq address[:address]
      end
    end

    context 'updates an exists billing address' do
      before do
        order.billing_address = create(:address)
        subject.save_billing_address(address)
      end

      it 'updates attributes' do
        expect(subject.billing_address.first_name).to eq address[:first_name]
        expect(subject.billing_address.address).to eq address[:address]
      end
    end
  end

  describe '#save_shipping_address' do
    let(:address) { attributes_for(:address) }

    context 'creates a new shipping address' do
      before do
        subject.save_shipping_address(address)
      end

      it 'saves attributes' do
        expect(subject.shipping_address.first_name).to eq address[:first_name]
        expect(subject.shipping_address.address).to eq address[:address]
      end
    end

    context 'updates an exists shipping address' do
      before do
        order.shipping_address = create(:address)
        subject.save_shipping_address(address)
      end

      it 'updates attributes' do
        expect(subject.shipping_address.first_name).to eq address[:first_name]
        expect(subject.shipping_address.address).to eq address[:address]
      end
    end
  end

  xdescribe '#save_payment_settings' do
    let(:credit_card) { attributes_for(:credit_card, user: user) }

    context 'creates a new credit_card' do
      before do
        subject.save_payment_settings(credit_card)
      end

      it 'saves attributes' do
        expect(subject.user.credit_card.number).to eq credit_card[:number]
      end
    end

    context 'updates an exists payment settings' do
      before do
        order.user.credit_card = create(:credit_card)
        subject.save_payment_settings(credit_card)
      end

      it 'updates attributes' do
        expect(subject.user.credit_card.number).to eq credit_card[:number]
      end
    end
  end
end
