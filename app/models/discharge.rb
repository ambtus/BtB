# frozen_string_literal: true

class Discharge < ApplicationRecord
  belongs_to :debt
  belongs_to :other, optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  before_validation { self.date = Time.zone.today if date.blank? }

  def self.others = Other.where(type: Discharge).sort_by { |o| o.name.downcase }
end
