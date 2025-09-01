# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Asset, type: :model do
  describe 'payoff between asset and debt' do
    before do
      checking_asset.incomes.create!(amount: 10)
      visa_debt.charges.create!(amount: 5)
    end

    describe 'success' do
      before { described_class.payoff(5, checking_asset, visa_debt) }

      it 'creates a outgo' do
        expect(Outgo.count).to be 1
      end

      it 'with a visa other' do
        expect(Outgo.first.other.name).to eq 'Visa'
      end

      it 'creates a discharge' do
        expect(Discharge.count).to be 1
      end

      it 'with a checking other' do
        expect(Discharge.first.other.name).to eq 'Checking'
      end

      it 'does change the assets' do
        expect(described_class.net).to be 5
      end

      it 'does change the debts' do
        expect(Debt.net).to be 0
      end

      it 'reduces the sender' do
        expect(checking_asset.net).to be 5
      end

      it 'decreases the receiver' do
        expect(visa_debt.net).to be 0
      end
    end

    describe 'tomorrow' do
      before { described_class.payoff(5, checking_asset, visa_debt, Date.tomorrow) }

      it 'creates an outgo for tomorrow' do
        expect(Outgo.first.date).to eq Date.tomorrow
      end

      it 'creates a discharge for tomorrow' do
        expect(Discharge.first.date).to eq Date.tomorrow
      end
    end

    describe 'yesterday' do
      before { described_class.payoff(5, checking_asset, visa_debt, Date.yesterday) }

      it 'creates an outgo for tomorrow' do
        expect(Outgo.first.date).to eq Date.yesterday
      end

      it 'creates a discharge for tomorrow' do
        expect(Discharge.first.date).to eq Date.yesterday
      end
    end

    describe 'failure: insufficient funds' do
      before { described_class.payoff(15, checking_asset, visa_debt) }

      it 'does not creates a outgo' do
        expect(Outgo.count).to be 0
      end

      it 'does not creates a discharge' do
        expect(Discharge.count).to be 0
      end

      it 'does not change the assets' do
        expect(described_class.net).to be 10
      end

      it 'does not change the debts' do
        expect(Debt.net).to be 5
      end

      it 'does not reduce the sender' do
        expect(checking_asset.net).to be 10
      end

      it 'does not decrease the receiver' do
        expect(visa_debt.net).to be 5
      end
    end

    describe 'payment followed by payoff' do
      before do
        checking_asset.incomes.create!(amount: 10)
        itunes_debt.charges.create!(amount: 5)
        Debt.payment(5, visa_debt, itunes_debt)
        described_class.payoff(5, checking_asset, visa_debt)
      end

      it 'creates four others' do
        expect(Other.count).to be 4
      end

      it 'creates two with the same name' do
        expect(Other.where(name: 'VISA').count).to be 2
      end
    end
  end
end
