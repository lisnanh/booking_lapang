class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :fields 
  has_many :bookings
  has_many :payments, through: :bookings
  has_many :management_fields

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  
end
