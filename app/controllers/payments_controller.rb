class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @pledge = Pledge.find params[:pledge_id]
  end

  def create
    pledge = Pledge.find params[:pledge_id]
    service = Payments::HandlePayment.new(pledge: pledge,
                                          user: current_user,
                                          stripe_token: params[:stripe_token])
    if service.call
      redirect_to campaign_path(pledge.campaign), notice: "Payment completed!"
    else
      redirect_to campaign_path(pledge.campaign), alert: "Something went wrong!"
    end
  end
end
