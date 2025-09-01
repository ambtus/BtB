# frozen_string_literal: true

class Debt < ApplicationRecord
  has_many :charges, dependent: :destroy
  has_many :discharges, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.net = all.sum(&:net)
  def net = charges.sum(&:amount) - discharges.sum(&:amount)

  def reconciled_charges = charges.where(reconciled: true)
  def reconciled_discharges = discharges.where(reconciled: true)

  def reconciled = reconciled_charges.sum(&:amount) - reconciled_discharges.sum(&:amount)

  def unreconciled_charges = charges.where(reconciled: false)
  def unreconciled_discharges = discharges.where(reconciled: false)

  def unreconciled = unreconciled_charges.sum(&:amount) - unreconciled_discharges.sum(&:amount)

  def self.payment(amount, sender, receiver, date = Time.zone.today)
    return false if sender == receiver
    return false unless amount.positive?

    other1 = Other.find_or_create_by!(type: Charge, name: receiver.name)
    other2 = Other.find_or_create_by!(type: Discharge, name: sender.name)

    sender.charges.create!(amount: amount, other: other1, date: date)
    receiver.discharges.create!(amount: amount, other: other2, date: date)
  end
end
