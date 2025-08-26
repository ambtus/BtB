# frozen_string_literal: true

class IncomesController < ApplicationController
  before_action :set_income, except: %i[new create]
  before_action :set_asset

  def new = (@income = Income.new(asset: @asset))

  def edit = (@title = "Edit #{@income.asset.name} Income")

  def create
    @income = @asset.incomes.build(income_params)
    if @income.save
      redirect_to asset_path(@asset), notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'new'
    end
  end

  def reconcile
    @income.update!(reconciled: true)
    redirect_to asset_path(@asset)
  end

  def unreconcile
    @income.update!(reconciled: false)
    redirect_to asset_path(@asset)
  end

  def update
    if @income.update(income_params)
      redirect_to @income.asset, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'edit'
    end
  end

  def delete = (@title = "Delete #{@income.asset.name} Income")

  def destroy
    @income.destroy!
    redirect_to asset_url(@income.asset), alert: "#{@income.asset.name} income was destroyed!"
  end

  def keep
    redirect_to asset_url(@income.asset), notice: 'Great!'
  end

  private

  def set_income = (@income = Income.find(params[:id]))

  def set_asset
    @asset =
      if params[:asset_id]
        Asset.find(params[:asset_id])
      else
        @income.asset
      end
  end

  # You can use the same list for both create and update.
  def income_params
    params.expect(income: %i[date other_id memo asset_id])
          .merge(amount: amount)
  end
end
