# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActionController::ParameterMissing, with: :keep

  def home = (@title = 'Home')

  def payoff
    @title = 'New Payoff'
    @outgo = Outgo.new
  end

  def post_payoff
    if make_payoff
      redirect_to home_path, notice: 'Payoff succeeded!'
    else
      @outgo = Outgo.new(amount: amount)
      flash.now[:alert] = 'Payoff Failure!'
      render 'payoff'
    end
  end

  before_action :set_title
  def set_title
    @title = "#{action_name.capitalize} #{controller_name.singularize.capitalize}"
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

  def make_payoff
    Asset.payoff(amount,
                 Asset.find(params[:sender_id]),
                 Debt.find(params[:receiver_id]),
                 params[:date])
  end
end
