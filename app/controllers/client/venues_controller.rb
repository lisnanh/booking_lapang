class Client::VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  def index
    @venues = Venue.all
    @cities = Field.select(:city).where(city: ['Jakarta', 'Bandung', 'Surabaya', 'Yogyakarta', 'Semarang']).distinct.pluck(:city)
    @field_types = ['Mini Soccer', 'Futsal']
  end

  def show
    @venue = Venue.find(params[:id])
    @fields = @venue.fields
    @selected_date = params[:date] || Date.today
    @available_fields = @fields.select do |field|
      field.schedules.any? { |schedule| schedule.date == @selected_date && !schedule.booked? }
    end
  end

  def new
    @venue = current_user.venues.build
    @cities = ["Jakarta", "Bandung", "Surabaya", "Yogyakarta", "Semarang"]
    @field_types = ['Mini Soccer', 'Futsal']
  end

  def create
    @venue = current_user.venues.build(venue_params)
    @cities = ["Jakarta", "Bandung", "Surabaya", "Yogyakarta", "Semarang"]
    @field_types = ['Mini Soccer', 'Futsal']

    respond_to do |format|
      if @venue.save
        format.html { redirect_to client_venue_path(@venue), notice: 'Venue was successfully created.' }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to client_venue_path(@venue), notice: 'Venue was successfully updated.' }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to client_venues_url, notice: 'Venue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, :address, :image, :field_type, :price, :description, :venue_id)
  end
end
