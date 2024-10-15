class Field < ApplicationRecord
has_many :bookings, dependent: :destroy
belongs_to :user
belongs_to :venue
validates :venue_id, presence: true # Pastikan venue_id ada
validates :user_id, presence: true 

validates :name, presence: true
  validates :field_type, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }


has_one_attached :image
has_many :schedules, dependent: :destroy

end
