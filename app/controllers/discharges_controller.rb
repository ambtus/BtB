# frozen_string_literal: true

class DischargesController < ApplicationController
  before_action :set_discharge, except: %i[index new create]
  before_action :set_debt

  def index = (@discharges = Discharge.all)

  def new = (@discharge = Discharge.new(debt: @debt))

  def edit = (@title = "Edit #{@discharge.debt.name} Discharge")

  def create
    @discharge = @debt.discharges.build(discharge_params)
    if @discharge.save
      redirect_to @discharge, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'new'
    end
  end

  def update
    if @discharge.update(discharge_params)
      redirect_to @discharge.debt, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'edit'
    end
  end

  def delete = (@title = "Delete #{@discharge.debt.name} Discharge")

  def destroy
    @discharge.destroy!
    redirect_to debt_url(@discharge.debt), alert: "#{@discharge.debt.name} discharge was destroyed!"
  end

  def keep
    redirect_to debt_url(@discharge.debt), notice: 'Great!'
  end

  private

  def set_discharge = (@discharge = Discharge.find(params[:id]))


  def set_debt
    @debt =
      if params[:debt_id]
        Debt.find(params[:debt_id])
      else
        @discharge.debt
      end
  end

  # You can use the same list for both create and update.
  def discharge_params
     params.expect(discharge: %i[date debt_id recipient_id memo])
     .merge(amount: amount)
  end
end
