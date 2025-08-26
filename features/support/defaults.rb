# frozen_string_literal: true

def checking_asset = Asset.find_or_create_by(name: 'Checking')
def savings_asset = Asset.find_or_create_by(name: 'Savings')

def visa_debt = Debt.find_or_create_by(name: 'Visa')
def itunes_debt = Debt.find_or_create_by(name: 'iTunes')

def income_other = Other.find_or_create_by(name: 'cash income', type: Income)
def outgo_other = Other.find_or_create_by(name: 'cash outgo', type: Outgo)
def charge_other = Other.find_or_create_by(name: 'credit charge', type: Charge)
def discharge_other = Other.find_or_create_by(name: 'credit discharge', type: Discharge)

def sizes = %w[zero small medium large compound complex future]

def amount_hash
  { zero: 0,
   small: 50,
  medium: 50_00,
   large: 50_000_00,
compound: 50_050_50,
 complex: 1_234_56,
  future: 12_34 }
end

def currency(word) = amount_hash[word.to_sym]

def string_hash
  { zero: '0c',
   small: '50c',
  medium: '$50',
   large: '$50,000',
compound: '$50,050.50',
 complex: '$1,234.56',
  future: '$12.34' }
end

def currency_string(word) = string_hash[word.to_sym]

def hash_hash
  { zero: { cents: 0, dollars: 0, thousands: 0 },
   small: { cents: 50, dollars: 0, thousands: 0 },
  medium: { cents: 0, dollars: 50, thousands: 0 },
   large: { cents: 0, dollars: 0, thousands: 50 },
compound: { cents: 50, dollars: 50, thousands: 50 },
 complex: { cents: 56, dollars: 234, thousands: 1 },
  future: { cents: 34, dollars: 12, thousands: 0 } }
end

def currency_hash(word) = hash_hash[word.to_sym]
