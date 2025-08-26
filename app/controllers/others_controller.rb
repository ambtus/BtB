# frozen_string_literal: true

class OthersController < ApplicationController
  before_action :set_other, except: %i[new create]
  before_action :set_type

  def show = (@title = "#{@other.name} Other")

  def new
    @other = Other.new
    @title = "New #{@type} Other"
  end

  def edit = (@title = "Edit #{@other.name} Other")

  def create
    @other = Other.new(other_params)
    if @other.save
      redirect_to home_path, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'new'
    end
  end

  def update
    if @other.update(other_params)
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

  def delete = (@title = "Delete #{@other.name} Other")

  def destroy
    @other.destroy!
    redirect_to home_path, alert: "#{@other.name} was destroyed!"
  end

  private

  def set_other = (@other = Other.find(params[:id]))

  def set_type
    @type =
      if params[:format]
        params[:format]
      elsif @other
        @other.type
      end
  end

  # You can use the same list for both create and update.
  def other_params = params.expect(other: %i[name type])
end
