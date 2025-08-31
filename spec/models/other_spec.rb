# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Other, type: :model do
  describe 'aggragates' do
    before do
      checking_asset.incomes.create!(amount: 5, other: income_other)
      checking_asset.incomes.create!(amount: 15, other: income_other,
                                     date: Time.zone.today - 31.days)
    end

    it 'total' do
      expect(income_other.total).to be 20
    end

    it 'this month' do
      expect(income_other.last30).to be 5
    end
  end

  describe 'name' do
    it 'is unique within type' do
      income_other

      expect(described_class.new(type: Income, name: income_other.name.titleize)).not_to be_valid
    end

    it 'can be shared between types' do
      income_other

      expect(described_class.new(type: Outgo, name: income_other.name.titleize)).to be_valid
    end

    it 'cannot be blank' do
      expect(described_class.new(type: Outgo)).not_to be_valid
    end
  end

  it 'must have a type' do
    expect(described_class.new(name: 'something')).not_to be_valid
  end
end
