require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validations" do
    it "requires an email" do
      attributes = FactoryGirl.attributes_for(:user)
      attributes[:email] = nil
      user = User.new attributes
      user.valid?
      expect(user.errors).to have_key(:email)
    end

    it "requires a unique email" do
      # GIVEN: a user created a in the database
      user = FactoryGirl.create(:user)
      # WHEN: we try to create a user with the same email
      attributes = FactoryGirl.attributes_for :user
      attributes[:email] = user.email
      user1 = User.new attributes
      user1.valid?
      # THEN: there is an error on the email field
      expect(user1.errors).to have_key :email
    end
    it "requires a first name" do
      # attributes = FactoryGirl.attributes_for :user
      # attributes[:first_name] = nil
      # user = User.new attributes
      # the 3 lines above are equivalent of the one line below
      user = User.new FactoryGirl.attributes_for(:user).merge({first_name: nil})
      user.valid?
      expect(user.errors).to have_key(:first_name)
    end

  end

end
