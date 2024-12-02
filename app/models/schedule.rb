class Schedule < ApplicationRecord
  belongs_to :field

  def booked?
    Booking.exists?(schedule_id: self.id)
  end
end
