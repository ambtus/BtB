# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Income, type: :model do
  describe 'amount' do
    it 'must not be blank' do
      expect(checking_asset.incomes.build).not_to be_valid
    end

    it 'must be greater than 0' do
      expect(checking_asset.incomes.build(amount: -1)).not_to be_valid
    end

    it 'must not be 0' do
      expect(checking_asset.incomes.build(amount: 0)).not_to be_valid
    end
  end

  describe 'date' do
    it 'defaults to today' do
      expect(checking_asset.incomes.create!(amount: 5).date).to eq Time.zone.today
    end

    it 'can be set' do
      expect(checking_asset.incomes.create!(amount: 5, date: Date.tomorrow).date).to eq Date.tomorrow
    end
  end

  describe 'memo' do
    it 'is squished' do
      expect(checking_asset.incomes.create!(amount: 5, memo: 'from x ').memo).to eq 'from x'
    end

    it 'cannot be overly long' do
      expect { checking_asset.incomes.create!(amount: 5, memo: 'x' * 64) }.to raise_error ActiveRecord::ValueTooLong
    end
  end

  describe 'other' do
    it 'can be set' do
      expect(checking_asset.incomes.create!(amount: 5,
                                             other: income_other).other.name).to eq 'cash income'
    end

    it 'can be unset' do
      income = checking_asset.incomes.create!(amount: 5, other: income_other)
      income_other.destroy!
      income.reload
      expect(income.other).to be_nil
    end
  end
end
