class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :campaign

  validates :amount, presence: true, numericality: {greater_than: 0}
end
