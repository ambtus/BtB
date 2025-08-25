# frozen_string_literal: true

class DebtsController < ApplicationController
  before_action :set_debt, except: %i[new create payment post_payment]

  def show = (@title = "#{@debt.name} Debt")

  def new = (@debt = Debt.new)

  def edit = (@title = "Edit #{@debt.name} Debt")

  def create
    @debt = Debt.new(debt_params)
    if @debt.save
      redirect_to home_path, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'new'
    end
  end

  def payment
    @payment = Discharge.new
    @title = 'New Payment'
  end

  def post_payment
    debt_ids = params.expect(:sender_id, :receiver_id)
    if Debt.payment(amount, Debt.find(debt_ids.first), Debt.find(debt_ids.second))
      redirect_to home_path, notice: 'Payment succeeded!'
    else
      @payment = Discharge.new(amount: amount)
      flash.now[:alert] = 'Payment Failure!'
      render 'payment'
    end
  end

  def update
    if @debt.update(debt_params)
      redirect_to home_path, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'edit'
    end
  end

  def keep
    flash.now[:notice] = 'Great!'
    render 'show'
  end

  def delete = (@title = "Delete #{@debt.name} Debt")

  def destroy
    @debt.destroy!
    redirect_to home_path, alert: "#{@debt.name} was destroyed!"
  end

  private

  def set_debt = (@debt = Debt.find(params[:id]))

  # You can use the same list for both create and update.
  def debt_params = params.expect(debt: %i[name memo])
end
