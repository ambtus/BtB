# frozen_string_literal: true

class OutgoesController < ApplicationController
  before_action :set_outgo, except: %i[new create]
  before_action :set_asset

  def new = (@outgo = Outgo.new(asset: @asset))

  def edit = (@title = "Edit #{@outgo.asset.name} Outgo")

  def create
    @outgo = @asset.outgoes.build(outgo_params)
    if @outgo.save
      redirect_to asset_path(@asset), notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'new'
    end
  end

  def reconcile
    @outgo.update!(reconciled: true)
    redirect_to asset_path(@asset)
  end

  def unreconcile
    @outgo.update!(reconciled: false)
    redirect_to asset_path(@asset)
  end

  def update
    if @outgo.update(outgo_params)
      redirect_to @outgo.asset, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'edit'
    end
  end

  def delete = (@title = "Delete #{@outgo.asset.name} Outgo")

  def destroy
    @outgo.destroy!
    redirect_to asset_url(@outgo.asset), alert: "#{@outgo.asset.name} outgo was destroyed!"
  end

  def keep
    redirect_to asset_url(@outgo.asset), notice: 'Great!'
  end

  private

  def set_outgo = (@outgo = Outgo.find(params[:id]))

  def set_asset
    @asset =
      if params[:asset_id]
        Asset.find(params[:asset_id])
      else
        @outgo.asset
      end
  end

  # You can use the same list for both create and update.
  def outgo_params
    params.expect(outgo: %i[date asset_id other_id memo])
          .merge(amount: amount)
  end
end
