class ApplicationController < ActionController::Base
    before_action :set_venue, if: -> { params[:venue_id].present? }

    private
  
    def set_venue
      @venue = Venue.find(params[:venue_id]) if params[:venue_id].present?
    end
end
