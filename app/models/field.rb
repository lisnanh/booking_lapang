class Field < ApplicationRecord
has_many :bookings, dependent: :destroy
belongs_to :user
belongs_to :venue
has_one_attached :image
has_many :schedules, dependent: :destroy

end
