class Booking < ApplicationRecord
    has_one :payment 
    belongs_to :user
    belongs_to :field

end
