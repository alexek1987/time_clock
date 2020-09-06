class Job < ApplicationRecord
  belongs_to :user
  has_many :shifts

  validates :position, presence: true
end

