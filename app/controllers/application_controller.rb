# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActionController::ParameterMissing, with: :keep

  def home = (@title = 'Home')

  before_action :title
  def title
    @title =
      if action_name == 'index'
        controller_name.capitalize
      else
        "#{action_name.capitalize} #{controller_name.singularize.capitalize}"
      end
  end

  def amount = amount_from_hash(amount_params)

  private

  def amount_from_hash(amount_hash)
    (1000 * 100 * amount_hash['thousands'].to_i) +
      (100 * amount_hash['dollars'].to_i) +
      amount_hash['cents'].to_i
  end

  def amount_params
    params.expect(amount: %i[thousands dollars cents])
  end
end
