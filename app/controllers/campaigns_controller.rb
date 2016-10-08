class CampaignsController < ApplicationController
  def new
    @campaign = Campaign.new
    #  we need to build campaigns in here in order for it to show correctly on the form
    # so we can save rewards at the same time we create a campaign
    3.times { @campaign.rewards.build}
  end

  def create
    # codes below is hindering the testing for invalid_request so we block it out
    # @campaign = Campaign.create params.require(:campaign).permit(:title, :description, :goal, :end_date)

    # redirect_to campaign_path(@campaign), notice: "Campaign created!"


    @campaign = Campaign.new params.require(:campaign).permit(:title, :description, :goal, :address, :end_date, {rewards_attributes: [:title, :body, :amount, :_destroy, :id]})

    if @campaign.save
      redirect_to campaign_path(@campaign), notice: "Campaign created!"
    else
      render :new
    end

  end

  def show
    @campaign = Campaign.find params[:id]
    @pledge = Pledge.new
  end

  def index
    if params[:lat]
      @campaigns = Campaign.near([params[:lat], params[:lng]], 50, units: :km)
    else
      @campaigns = Campaign.where.not(latitude: nil, longitude: nil).order(:created_at).limit(30)
    end
    @markers = Gmaps4rails.build_markers(@campaigns) do |campaign, marker|
      marker.lat  campaign.latitude
      marker.lng  campaign.longitude
      marker.infowindow  campaign.title
    end
  end

  def destroy
    campaign = Campaign.find params[:id]
    campaign.destroy
    redirect_to campaigns_path, notice: "Campaign deleted!"
  end
end
