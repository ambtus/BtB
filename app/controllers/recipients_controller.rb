# frozen_string_literal: true

class RecipientsController < ApplicationController
  before_action :set_recipient, except: %i[index new create]
  def index = (@recipients = Recipient.all)

  def show = (@title = "#{@recipient.name} #{@recipient.type}")

  def new
    @recipient = Recipient.new
    @type = params[:format]
  end

  def edit = (@title = "Edit #{@recipient.name} Recipient")

  def create
    @recipient = Recipient.new(recipient_params)
    if @recipient.save
      redirect_to home_path, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'new'
    end
  end

  def update
    if @recipient.update(recipient_params)
      redirect_to recipients_path, notice: 'Success!'
    else
      flash.now[:alert] = 'Failure!'
      render 'edit'
    end
  end

  def keep
    flash.now[:notice] = 'Great!'
    render 'show'
  end

  def delete = (@title = "Delete #{@recipient.name} Recipient")

  def destroy
    @recipient.destroy!
    redirect_to recipients_path, alert: "#{@recipient.name} was destroyed!"
  end

  private

  def set_recipient = (@recipient = Recipient.find(params[:id]))

  # You can use the same list for both create and update.
  def recipient_params = params.expect(recipient: %i[name type])
end
