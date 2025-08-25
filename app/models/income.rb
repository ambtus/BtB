# frozen_string_literal: true

class Income < ApplicationRecord
  belongs_to :asset
  belongs_to :recipient, optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  before_validation { self.date = Time.zone.today if date.blank? }

  def self.recipients = Recipient.where(type: Income)
end
