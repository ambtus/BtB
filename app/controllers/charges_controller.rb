# frozen_string_literal: true

class ChargesController < ApplicationController
  before_action :set_charge, except: %i[index new create]
  before_action :set_debt
  def index = (@charges = Charge.all)

  def new = (@charge = Charge.new(debt: @debt))

  def edit = (@title = "Edit #{@charge.debt.name} Charge")

  def create
    @charge = Charge.new(charge_params)
    if @charge.save
      redirect_to @charge, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'new'
    end
  end

  def update
    if @charge.update(charge_params)
      redirect_to @charge.debt, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'edit'
    end
  end

  def delete = (@title = "Delete #{@charge.debt.name} Charge")

  def destroy
    @charge.destroy!
    redirect_to debt_url(@charge.debt), alert: "#{@charge.debt.name} charge was destroyed!"
  end

  def keep
    redirect_to debt_url(@charge.debt), notice: 'Great!'
  end

  private

  def set_charge = (@charge = Charge.find(params[:id]))


  def set_debt
    @debt =
      if params[:debt_id]
        Debt.find(params[:debt_id])
      elsif @charge
        @charge.debt
      else
        Debt.new
      end
  end

  # You can use the same list for both create and update.
  def charge_params = params.expect(charge: %i[date debt_id recipient_id memo]).merge(amount: amount)
end
