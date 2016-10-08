class PublishingsController < ApplicationController
  def create
    campaign = Campaign.find params[:campaign_id]
    if campaign.publish!
      redirect_to campaign, notice: "Campaign is published"
    else
      redirect_to campaign, notice: "Couldn't publish Campaign"
    end
  end
end
