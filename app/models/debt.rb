# frozen_string_literal: true

class Debt < ApplicationRecord
  has_many :charges, dependent: :destroy
  has_many :discharges, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.net = all.sum(&:net)
  def net = charges.sum(&:amount) - discharges.sum(&:amount)

  def self.payment(amount, sender, receiver)
    return false if sender == receiver

    sender.discharges.create!(amount: amount)
    receiver.charges.create!(amount: amount)
  end
end
