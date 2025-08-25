# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  normalizes :name, with: ->(name) { name.squish }
  normalizes :memo, with: ->(memo) { memo.squish }

  def amount_hash
    return {} if amount.nil?

    thousands, remainder = amount.divmod(100_000)
    dollars, cents = remainder.divmod(100)
    { cents: cents, dollars: dollars, thousands: thousands }
  end

  def thousands = amount_hash[:thousands]
  def dollars = amount_hash[:dollars]
  def cents = amount_hash[:cents]
end
