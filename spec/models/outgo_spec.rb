# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Outgo, type: :model do
  describe 'amount' do
    it 'must not be blank' do
      expect(checking_asset.outgoes.build).not_to be_valid
    end

    it 'must be greater than 0' do
      expect(checking_asset.outgoes.build(amount: -1)).not_to be_valid
    end

    it 'must not be 0' do
      expect(checking_asset.outgoes.build(amount: 0)).not_to be_valid
    end

    it 'cannot be more than asset net' do
      expect(checking_asset.outgoes.build(amount: 5)).not_to be_valid
    end

    it 'can be equal to asset net' do
      checking_asset.incomes.create!(amount: 5)
      expect(checking_asset.outgoes.build(amount: 5)).to be_valid
    end

    it 'can be less than asset net' do
      checking_asset.incomes.create!(amount: 10)
      expect(checking_asset.outgoes.build(amount: 5)).to be_valid
    end
  end

  describe 'date' do
    it 'defaults to today' do
      checking_asset.incomes.create!(amount: 5)

      expect(checking_asset.outgoes.create!(amount: 5).date).to eq Time.zone.today
    end

    it 'can be set' do
      checking_asset.incomes.create!(amount: 5)

      expect(checking_asset.outgoes.create!(amount: 5, date: Date.tomorrow).date).to eq Date.tomorrow
    end
  end

  describe 'memo' do
    before { checking_asset.incomes.create!(amount: 10) }

    it 'is squished' do
      expect(checking_asset.outgoes.create!(amount: 5, memo: ' to x').memo).to eq 'to x'
    end

    it 'cannot be overly long' do
      expect { checking_asset.outgoes.create!(amount: 5, memo: 'x' * 64) }.to raise_error ActiveRecord::ValueTooLong
    end
  end

  describe 'other' do
    it 'can be set' do
      expect(checking_asset.outgoes.create!(amount: 5, other: outgo_other).other.name).to eq 'cash outgo'
    end

    it 'can be unset' do
      outgo = checking_asset.outgoes.create!(amount: 5, other: outgo_other)
      outgo_other.destroy!
      outgo.reload
      expect(outgo.other).to be_nil
    end
  end
end
