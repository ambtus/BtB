# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Debt, type: :model do
  describe 'name' do
    it 'cannot be blank' do
      expect(described_class.new).not_to be_valid
    end

    it 'must be uniq' do
      visa_debt
      expect(described_class.new(name: 'VISA')).not_to be_valid
    end

    it 'is squished' do
      a = described_class.create!(name: '  Chase  VISA ')
      expect(a.name).to eq 'Chase VISA'
    end

    it 'cannot be overly long' do
      expect { described_class.create!(name: 'x' * 64) }.to raise_error ActiveRecord::ValueTooLong
    end
  end

  describe 'memo' do
    it 'can be blank' do
      expect(described_class.new(name: 'something', memo: nil)).to be_valid
    end

    it 'is squished' do
      expect(described_class.create!(name: 'a', memo: '  Chase  VISA ').memo).to eq 'Chase VISA'
    end

    it 'cannot be overly long' do
      expect { described_class.create!(name: 'a', memo: 'x' * 64) }.to raise_error ActiveRecord::ValueTooLong
    end
  end

  describe 'has charges and discharges' do
    it 'destroys all charges when destroyed' do
      visa_debt.charges.create!(amount: 5)
      visa_debt.destroy
      expect(Charge.count).to be 0
    end

    it 'destroys all discharges when destroyed' do
      visa_debt.discharges.create!(amount: 5)
      visa_debt.destroy
      expect(Discharge.count).to be 0
    end
  end

  describe 'net' do
    it 'starts empty' do
      expect(described_class.new.net).to be 0
    end

    it 'grows with its first charge' do
      visa_debt.charges.create!(amount: 5)
      expect(visa_debt.net).to eq 5
    end

    it 'grows more with more charges' do
      visa_debt.charges.create!(amount: currency('small'))
      visa_debt.charges.create!(amount: currency('medium'))
      visa_debt.charges.create!(amount: currency('large'))
      expect(visa_debt.net).to eq currency('compound')
    end

    it 'drains with each discharge' do
      visa_debt.charges.create!(amount: currency('compound'))
      visa_debt.discharges.create!(amount: currency('medium'))
      visa_debt.discharges.create!(amount: currency('small'))

      expect(visa_debt.net).to be currency('large')
    end

    it 'can be drained completely' do
      visa_debt.charges.create!(amount: 5)
      visa_debt.discharges.create!(amount: 5)
      expect(visa_debt.net).to be 0
    end

    it 'new discharge can be more than debt net' do
      expect(visa_debt.discharges.new(amount: 5)).to be_valid
    end
  end

  describe 'payments between accounts' do
    before { itunes_debt.charges.create!(amount: 10) }

    describe 'success' do
      before { described_class.payment(5, itunes_debt, visa_debt) }

      it 'creates a discharge' do
        expect(Discharge.count).to be 1
      end

      it 'with a visa other' do
        expect(Discharge.first.other.name).to eq 'Visa'
      end

      it 'creates a charge' do
        expect(Charge.count).to be 2
      end

      it 'with a iTunes other' do
        expect(Charge.last.other.name).to eq 'iTunes'
      end

      it 'does not change the net' do
        expect(described_class.net).to be 10
      end

      it 'reduces the sender' do
        expect(itunes_debt.net).to be 5
      end

      it 'increases the receiver' do
        expect(visa_debt.net).to be 5
      end
    end

    describe 'failure: same debt' do
      before { described_class.payment(5, visa_debt, visa_debt) }

      it 'does not creates a discharge' do
        expect(Discharge.count).to be 0
      end

      it 'does not creates a new charge' do
        expect(Charge.count).to be 1
      end

      it 'does not change the net' do
        expect(described_class.net).to be 10
      end
    end
  end
end
