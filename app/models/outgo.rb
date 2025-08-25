# frozen_string_literal: true

class Outgo < ApplicationRecord
  belongs_to :asset
  belongs_to :recipient, optional: true

  before_validation :funds_available?
  before_validation { self.date = Time.zone.today if date.blank? }

  def self.recipients = Recipient.where(type: Outgo)

  private

  def funds_available?
    # asset.net includes this outgo
    if amount.nil?
      errors.add(:amount, 'must not be blank')
    elsif amount <= 0
      errors.add(:amount, 'must be greater than zero')
    elsif asset.net.negative?
      errors.add(:amount, 'must be less than asset net')
    else
      return true
    end
    false
  end
end
