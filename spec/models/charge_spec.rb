# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Charge, type: :model do
  describe 'amount' do
    it 'must not be blank' do
      expect(visa_debt.charges.build).not_to be_valid
    end

    it 'must be greater than 0' do
      expect(visa_debt.charges.build(amount: -1)).not_to be_valid
    end

    it 'must not be 0' do
      expect(visa_debt.charges.build(amount: 0)).not_to be_valid
    end

    it 'can be 1' do
      expect(visa_debt.charges.build(amount: 1)).to be_valid
    end
  end

  describe 'debt' do
    it 'is not valid without a debt' do
      expect(described_class.new(amount: 1)).not_to be_valid
    end

    it 'is valid with a debt' do
      expect(described_class.new(amount: 1, debt: visa_debt)).to be_valid
    end
  end

  describe 'date' do
    it 'defaults to today' do
      expect(visa_debt.charges.create!(amount: 5).date).to eq Time.zone.today
    end

    it 'can be set' do
      expect(visa_debt.charges.create!(amount: 5, date: Date.tomorrow).date).to eq Date.tomorrow
    end
  end

  describe 'memo' do
    it 'is squished' do
      expect(visa_debt.charges.create!(amount: 5, memo: 'from x ').memo).to eq 'from x'
    end

    it 'cannot be overly long' do
      expect { visa_debt.charges.create!(amount: 5, memo: 'x' * 64) }.to raise_error ActiveRecord::ValueTooLong
    end
  end

  describe 'other' do
    it 'can be set' do
      expect(visa_debt.charges.create!(amount: 5,
                                        other: charge_other).other.name).to eq 'credit charge'
    end

    it 'can be unset' do
      charge = visa_debt.charges.create!(amount: 5, other: charge_other)
      charge_other.destroy!
      charge.reload
      expect(charge.other).to be_nil
    end
  end
end
