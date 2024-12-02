class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :bookings
  has_many :payments, through: :bookings
  has_many :management_fields
  has_many :venues, dependent: :destroy
  has_many :fields, through: :venues

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
