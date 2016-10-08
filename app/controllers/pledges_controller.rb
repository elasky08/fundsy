class PledgesController < ApplicationController
  before_action :authenticate_user!

  def create
    @pledge = Pledge.new pledge_params
    @campaign = Campaign.find params[:campaign_id]
    @pledge.campaign = @campaign
    @pledge.user = current_user
    if @pledge.save
      redirect_to new_pledge_payment_path(@pledge)
    else
      render "campaigns/show"
    end
  end

  def destroy
    pledge = Pledge.find params[:id]
    pledge.destroy
  end

  private

  def pledge_params
    pledge = Pledge.find params[:pledge_id]
    params.require(:pledge).permit(:amount)
  end
end
