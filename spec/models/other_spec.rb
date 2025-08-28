# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Other, type: :model do
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
