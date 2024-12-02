class Booking < ApplicationRecord
    has_one :payment 
    belongs_to :user
    belongs_to :field
    belongs_to :schedule

end
