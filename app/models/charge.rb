# frozen_string_literal: true

class Charge < ApplicationRecord
  belongs_to :debt
  belongs_to :recipient, optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  before_validation { self.date = Time.zone.today if date.blank? }

  def self.recipients = Recipient.where(type: Charge)
end
