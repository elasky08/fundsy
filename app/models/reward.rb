class Reward < ApplicationRecord
  belongs_to :campaign, optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :title, presence: true
end
