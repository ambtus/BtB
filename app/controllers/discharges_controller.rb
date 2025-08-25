# frozen_string_literal: true

class DischargesController < ApplicationController
  before_action :set_discharge, except: %i[index new create]
  def index = (@discharges = Discharge.all)

  def new = (@discharge = Discharge.new)

  def edit = (@title = "Edit #{@discharge.asset.name} Discharge")

  def create
    @discharge = Discharge.new(discharge_params)
    if @discharge.save
      redirect_to @discharge, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'new'
    end
  end

  def update
    if @discharge.update(discharge_params)
      redirect_to @discharge.asset, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'edit'
    end
  end

  def delete = (@title = "Delete #{@discharge.asset.name} Discharge")

  def destroy
    @discharge.destroy!
    redirect_to asset_url(@discharge.asset), alert: "#{@discharge.asset.name} discharge was destroyed!"
  end

  def keep
    redirect_to asset_url(@discharge.asset), notice: 'Great!'
  end

  private

  def set_discharge = (@discharge = Discharge.find(params[:id]))

  # You can use the same list for both create and update.
  def discharge_params = params.expect(discharge: %i[date asset_id debt_id recipient_id memo]).merge(amount: amount)
end
