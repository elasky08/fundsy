FactoryGirl.define do
  # we define a factory in here for the campaign that help us easily create campaign records in the database. We can use this with RSpec or with seeds. FactoryGirl.create(:campaign)
  # Key thing to remember about factories: they should always generate valid records
  factory :campaign do
    # so we tell FactoryGirl how to generate data for each field. We have the option to provide static data such as a string or an integer or we can provide a block. If you provide static data then it will be the same for all the records. If you provide a block then you can put some code to generate random or unique data.
    sequence(:title)   {|n| Faker::Company.bs + n.to_s}
    description         {Faker::ChuckNorris.fact}
    goal                {10 + rand(100000)}
    end_date            {Time.now + 60.days}
  end
end
