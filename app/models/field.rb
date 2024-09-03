class Field < ApplicationRecord
has_many :bookings
belongs_to :user
has_one_attached :image

end
