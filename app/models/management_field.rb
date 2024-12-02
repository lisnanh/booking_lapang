class ManagementField < ApplicationRecord
  belongs_to :client
  has_many :bookings
  belongs_to :user
  belongs_to :venue
  has_one_attached :image
end
