class Campaign < ApplicationRecord
  has_many :rewards, dependent: :destroy

  # this gives us the possibility of creating rewards at the same time we create the campaign.
  # By passing a special key call ad: rewards_attributes
  accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true

  geocoded_by :address # address is the databse field
  after_validation :geocode # the geocode methods comes from the GEocoder gem.
                            # if you're doing geocoding a lot,it may be a good idea
                            # to move it to the background because it actually
                            # connects to an external service
  validates :title, presence: true, uniqueness: true

  # # if you havea multiple fields for the address you can do something like:
  # geocoded_by :full_street_address
  # def full_street_address
  #   "#{street} #{city} #{province} #{country} #{postal_code}"
  # end

  include AASM

  aasm do
    state :draft, initial: true
    state :published
    state :canceled
    state :goal_met
    state :goal_unmet

    event :publish do
      transitions from: :draft, to: :published
    end

    event :succeed do
      transitions from: :published, to: :goal_met
    end

    event :fail do
      transitions from: :published, to: :goal_unmet
    end

    event :cancel do
      transitions from: [:published, :goal_met], to: :canceled
    end

    event :raise_goal do
      transitions from: :goal_met, to: :published
    end
  end

  def titleized_title
    title.titleize
  end
end
