# frozen_string_literal: true

class AssetsController < ApplicationController
  before_action :set_asset, except: %i[new create transfer post_transfer]

  def show = (@title = "#{@asset.name} Asset")

  def new = (@asset = Asset.new)

  def edit = (@title = "Edit #{@asset.name} Asset")

  def create
    @asset = Asset.new(asset_params)
    if @asset.save
      redirect_to home_path, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'new'
    end
  end

  def transfer
    @transfer = Outgo.new
    @title = 'New Transfer'
  end

  def post_transfer
    if make_transfer
      redirect_to home_path, notice: 'Transfer succeeded!'
    else
      @transfer = Outgo.new(amount: amount)
      flash.now[:alert] = 'Transfer Failure!'
      render 'transfer'
    end
  end

  def reconcile = (@title = "Reconcile #{@asset.name} Asset")

  def update
    if @asset.update(asset_params)
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

  def delete = (@title = "Delete #{@asset.name} Asset")

  def destroy
    @asset.destroy!
    redirect_to home_path, alert: "#{@asset.name} was destroyed!"
  end

  private

  def set_asset = (@asset = Asset.find(params[:id]))

  # You can use the same list for both create and update.
  def asset_params = params.expect(asset: %i[name memo])

  def make_transfer
    Asset.transfer(amount,
                   Asset.find(params[:sender_id]),
                   Asset.find(params[:receiver_id]),
                   params[:date])
  end
end
