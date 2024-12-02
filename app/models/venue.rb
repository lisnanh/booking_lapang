class Venue < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  
  belongs_to :user
  has_many :fields, dependent: :destroy
  has_many :management_fields
  attribute :field_types, :string, array: true, default: []

  has_one_attached :image
end
