# frozen_string_literal: true

class Other < ApplicationRecord
  self.inheritance_column = nil
  has_many :incomes, dependent: :nullify
  has_many :outgoes, dependent: :nullify
  has_many :charges, dependent: :nullify
  has_many :discharges, dependent: :nullify

  validates :type, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :type }

  [Income, Outgo, Charge, Discharge].each do |model|
    define_method(model.name) { model.send(:others) }
  end

  def method = type.downcase.pluralize.to_sym
  def targets = send(method)

  def last30 = targets.where('date > ?', 30.days.ago).sum(&:amount)
  def total = targets.sum(&:amount)
end
