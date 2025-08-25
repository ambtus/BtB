# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Asset, type: :model do
  describe 'name' do
    it 'cannot be blank' do
      expect(described_class.new).not_to be_valid
    end

    it 'must be uniq' do
      checking_asset
      expect(described_class.new(name: 'Checking')).not_to be_valid
    end

    it 'is squished' do
      a = described_class.create!(name: '  BofA  Checking ')
      expect(a.name).to eq 'BofA Checking'
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
      expect(described_class.create!(name: 'a', memo: '  BofA  Checking ').memo).to eq 'BofA Checking'
    end

    it 'cannot be overly long' do
      expect { described_class.create!(name: 'a', memo: 'x' * 64) }.to raise_error ActiveRecord::ValueTooLong
    end
  end

  describe 'has incomes and outgoes' do
    it 'destroys all incomes when destroyed' do
      checking_asset.incomes.create!(amount: 5)
      checking_asset.destroy
      expect(Income.count).to be 0
    end

    it 'destroys all outgoes when destroyed' do
      checking_asset.incomes.create!(amount: 5)
      checking_asset.outgoes.create!(amount: 5)
      checking_asset.destroy
      expect(Outgo.count).to be 0
    end
  end

  describe 'net' do
    it 'starts empty' do
      expect(described_class.new.net).to be 0
    end

    it 'grows with its first income' do
      checking_asset.incomes.create!(amount: 5)
      expect(checking_asset.net).to eq 5
    end

    it 'grows more with more incomes' do
      checking_asset.incomes.create!(amount: currency('small'))
      checking_asset.incomes.create!(amount: currency('medium'))
      checking_asset.incomes.create!(amount: currency('large'))
      expect(checking_asset.net).to eq currency('compound')
    end

    it 'drains with each outgo' do
      checking_asset.incomes.create!(amount: currency('compound'))
      checking_asset.outgoes.create!(amount: currency('medium'))
      checking_asset.outgoes.create!(amount: currency('small'))

      expect(checking_asset.net).to be currency('large')
    end

    it 'can be drained completely' do
      checking_asset.incomes.create!(amount: 5)
      checking_asset.outgoes.create!(amount: 5)
      expect(checking_asset.net).to be 0
    end

    it 'new outgo cannot be more than asset net' do
      expect(checking_asset.outgoes.new(amount: 5)).not_to be_valid
    end
  end

  describe 'transfer between accounts' do
    before { savings_asset.incomes.create!(amount: 10) }

    describe 'success' do
      before { described_class.transfer(5, savings_asset, checking_asset) }

      it 'creates a outgo' do
        expect(Outgo.count).to be 1
      end

      it 'creates an income' do
        expect(Income.count).to be 2
      end

      it 'does not change the net' do
        expect(described_class.net).to be 10
      end

      it 'reduces the sender' do
        expect(savings_asset.net).to be 5
      end

      it 'increases the receiver' do
        expect(checking_asset.net).to be 5
      end
    end

    describe 'failure: insufficient funds' do
      before { described_class.transfer(15, savings_asset, checking_asset) }

      it 'does not creates a outgo' do
        expect(Outgo.count).to be 0
      end

      it 'does not creates an income' do
        expect(Income.count).to be 1
      end

      it 'does not change the net' do
        expect(described_class.net).to be 10
      end

      it 'does not reduce the sender' do
        expect(savings_asset.net).to be 10
      end

      it 'does not increase the receiver' do
        expect(checking_asset.net).to be 0
      end
    end

    describe 'failure: same asset' do
      before { described_class.transfer(5, savings_asset, savings_asset) }

      it 'does not creates a outgo' do
        expect(Outgo.count).to be 0
      end

      it 'does not creates an income' do
        expect(Income.count).to be 1
      end
    end
  end
end
