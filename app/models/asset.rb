# frozen_string_literal: true

class Asset < ApplicationRecord
  has_many :incomes, dependent: :destroy
  has_many :outgoes, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.net = all.sum(&:net)
  def net = incomes.sum(&:amount) - outgoes.sum(&:amount)

  def reconciled_incomes = incomes.where(reconciled: true)
  def reconciled_outgoes = outgoes.where(reconciled: true)

  def reconciled = reconciled_incomes.sum(&:amount) - reconciled_outgoes.sum(&:amount)

  def unreconciled_incomes = incomes.where(reconciled: false)
  def unreconciled_outgoes = outgoes.where(reconciled: false)

  def unreconciled = unreconciled_incomes.sum(&:amount) - unreconciled_outgoes.sum(&:amount)

  def self.transfer(amount, sender, receiver)
    return false if sender == receiver
    return false if amount > sender.net

    other1 = Other.find_or_create_by(type: Outgo, name: receiver.name)
    other2 = Other.find_or_create_by(type: Income, name: sender.name)

    sender.outgoes.create!(amount: amount, other: other1)
    receiver.incomes.create!(amount: amount, other: other2)
  end

  def self.payoff(amount, sender, receiver)
    return false if amount > sender.net

    other1 = Other.find_or_create_by(type: Outgo, name: receiver.name)
    other2 = Other.find_or_create_by(type: Discharge, name: sender.name)

    outgo = sender.outgoes.create!(amount: amount, other: other1)
    discharge = receiver.discharges.create!(amount: amount, other: other2)

  end
end
