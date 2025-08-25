# frozen_string_literal: true

class Asset < ApplicationRecord
  has_many :incomes, dependent: :destroy
  has_many :outgoes, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.net = all.sum(&:net)
  def net = incomes.sum(&:amount) - outgoes.sum(&:amount)

  def self.transfer(amount, sender, receiver)
    return false if sender == receiver
    return false if amount > sender.net

    sender.outgoes.create!(amount: amount)
    receiver.incomes.create!(amount: amount)
  end
end
