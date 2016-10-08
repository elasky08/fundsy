require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe "Validations" do
    # we can use 'it' method (or specify) to define a test example. The method takes a first argument which is the example description and it takes a block of code where you actually write your test. Make the description very clear so that the reader of the message knows the test is about
    it "require a title" do
      # GIVEN: a campaign record with no title
      c = Campaign.new

      # WHEN: we run validations
      c.valid?

      # THEN: the record is invalid (it has errors)
      # expect(c).to be_invalid
      expect(c.errors).to have_key(:title)
    end
    it "requires a unique title" do
      # GIVEN: a campaign created in the DB with a title. New campaign with the same title
      Campaign.create({title: "valid title", description: "abc", goal: 123, end_date: Time.now + 60.days})
      c = Campaign.new title: "valid title"

      # WHEN: we run validations
      c.valid?

      # THEN: the record is invalid (it has an error) on the title field
      expect(c.errors).to have_key(:title)
    end

    describe ".titleized_title" do
      it "returns a titleized version of the title" do
        # GIVEN: a campaign with a title
        c = Campaign.new title: "hello world"

        # WHEN: we call the titleized_title method
        outcome = c.titleized_title

        # THEN: we get back a titleized title version of the title
        expect(outcome).to eq("Hello World")
      end

    
    end
  end
end
