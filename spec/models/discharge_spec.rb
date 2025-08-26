# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Discharge, type: :model do
  describe 'amount' do
    it 'must not be blank' do
      expect(visa_debt.discharges.build).not_to be_valid
    end

    it 'must be greater than 0' do
      expect(visa_debt.discharges.build(amount: -1)).not_to be_valid
    end

    it 'must not be 0' do
      expect(visa_debt.discharges.build(amount: 0)).not_to be_valid
    end

    it 'can be more than debt net' do
      expect(visa_debt.discharges.build(amount: 5)).to be_valid
    end

    it 'can be equal to debt net' do
      visa_debt.charges.create!(amount: 5)
      expect(visa_debt.discharges.build(amount: 5)).to be_valid
    end

    it 'can be less than debt net' do
      visa_debt.charges.create!(amount: 10)
      expect(visa_debt.discharges.build(amount: 5)).to be_valid
    end
  end

  describe 'date' do
    it 'defaults to today' do
      visa_debt.charges.create!(amount: 5)

      expect(visa_debt.discharges.create!(amount: 5).date).to eq Time.zone.today
    end

    it 'can be set' do
      visa_debt.charges.create!(amount: 5)

      expect(visa_debt.discharges.create!(amount: 5, date: Date.tomorrow).date).to eq Date.tomorrow
    end
  end

  describe 'memo' do
    before { visa_debt.charges.create!(amount: 10) }

    it 'is squished' do
      expect(visa_debt.discharges.create!(amount: 5, memo: ' to x').memo).to eq 'to x'
    end

    it 'cannot be overly long' do
      expect { visa_debt.discharges.create!(amount: 5, memo: 'x' * 64) }.to raise_error ActiveRecord::ValueTooLong
    end
  end

  describe 'other' do
    it 'can be set' do
      expect(visa_debt.discharges.create!(amount: 5,
                                           other: discharge_other).other.name).to eq 'credit discharge'
    end

    it 'can be unset' do
      discharge = visa_debt.discharges.create!(amount: 5, other: discharge_other)
      discharge_other.destroy!
      discharge.reload
      expect(discharge.other).to be_nil
    end
  end
end
