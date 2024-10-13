class Venue < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  
  belongs_to :user
  has_many :fields, dependent: :destroy
  attribute :field_types, :string, array: true, default: []
end
