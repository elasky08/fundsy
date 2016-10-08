require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
    describe "#new" do
      it "renders the new template" do
        get :new
        # response here is a method RSpec rails that we can use to match the output or the result of making a specific request
        # render_template is a RSpec matcher for Rails
        expect(response).to render_template(:new)
      end
      it "instantiates a new campaign instance variable" do
        get :new
        # assigns(:campaign) will check a variable named @campaign defined within the controller.
        expect(assigns(:campaign)).to be_a_new(Campaign)
      end
    end

    describe "#create" do
      context "with valid parameters" do
        def valid_request
          post :create, params: { campaign: {title: "campaign title",
                                             description: "hello",
                                             goal: 100000,
                                             end_date: Time.now + 50.days} }
        end
        it "saves the record to the database" do
          count_before = Campaign.count
          # code below is now inside of method valid_request
          # post :create, params: { campaign: {title: "campaign title",
          #                                    description: "hello",
          #                                    goal: 100000,
          #                                    end_date: Time.now + 50.days} }
          valid_request
          count_after = Campaign.count
          expect(count_after).to eq(count_before + 1)
        end
        it "redirects to the campaign show page" do
          valid_request
          expect(response).to redirect_to(campaign_path(Campaign.last))
        end
        it "sets a flash message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "with invalid parameters" do
        def invalid_request
          post :create, params: {campaign: {title: ""}}
        end
        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end
        it "doesn't save the record to the database" do
          count_before = Campaign.count
          invalid_request
          count_after = Campaign.count
          expect(count_after).to eq(count_before)
        end
      end
    end

    describe "#show" do
      it "renders the show template" do
        # GIVEN: a campaign created in the database
        # the code below is blocked out because we assigned the hash inside of FactoryGirl's settings in the factories folder. So now we can just call it out.
        # campaign = Campaign.create({title: "valid campaign title",
        #                             description: "valid description",
        #                             goal: 100000,
        #                             end_date: Time.now + 50.days})

        campaign = FactoryGirl.create(:campaign)
        # WHEN: we make a GET request with id of the campaign
        get :show, params: {id: campaign.id}

        # THEN: renders the show template
        expect(response).to render_template(:show)
      end
      it "defines an instance variable for campaign on the said id" do
        campaign = FactoryGirl.create(:campaign)
        get :show, params: {id: campaign.id}
        expect(assigns(:campaign)).to eq(campaign)
      end
    end

    describe "#index" do
      it "renders index template" do
        get :index
        expect(response).to render_template(:index)
      end

      it "defines the instance variable for all campaigns" do
        campaign = FactoryGirl.create(:campaign)
        campaign1 = FactoryGirl.create(:campaign)
        get :index
        expect(assigns(:campaigns)).to eq([campaign, campaign1])
      end
    end

    describe "#destroy" do
      it "removes the record from the database" do
        # expect { delete :destroy, params: { id: c.id } }.to change { Campaign.count }.by(-1) #one line code for this spec
        # GIVEN: we have a campaign record in the database
        c = FactoryGirl.create(:campaign)
        count_before = Campaign.count
        # WHEN: we sent a delete request to the destroy action
        delete :destroy, params:{id: c.id}
        # THEN: the campaign record gets removed
        count_after = Campaign.count
        expect(count_after).to eq(count_before - 1)
      end

      it "redirects to the question listings page" do
        c = FactoryGirl.create :campaign
        delete :destroy, params: {id: c.id}
        expect(response).to redirect_to campaigns_path
      end

    end
end
