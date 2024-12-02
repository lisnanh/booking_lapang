class Client::BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_field, only: [:new, :create]
  before_action :set_venue, only: [:index]
  before_action :set_booking, only: [:show, :edit, :update, :destroy] # Hanya untuk aksi show, edit, update, destroy

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    @venue = Venue.find(params[:id])
  end

  # GET /fields/:field_id/bookings/new
  def new
    @venue = Venue.find(params[:venue_id])
    @field = Field.find(params[:field_id])
    @booking = @field.bookings.new
  
    @schedule = Schedule.find_by(field_id: @field.id)
    if @schedule.nil?
      redirect_to client_venues_path, alert: "Tidak ada jadwal untuk lapangan ini."
    elsif @schedule.booked?
      redirect_to client_venue_path(@schedule.client_field.client_venue), notice: "Lapangan ini sudah terbooking!"
    else
      @booking = ClientBooking.new(client_schedule: @schedule)
    end
  end


  # POST /fields/:field_id/bookings
  def create
    @booking = @field.bookings.build(booking_params)
    @booking.user_id = current_user.id
    respond_to do |format|
      if @booking.save
        format.html { redirect_to client_field_booking_path(@field, @booking), notice: "Booking was successfully created." }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /fields/:field_id/bookings/:id/edit
  def edit
  end

  # PATCH/PUT /fields/:field_id/bookings/:id
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to client_field_booking_path(@field, @booking), notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fields/:field_id/bookings/:id
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to client_field_bookings_path(@field), notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_venue
    @venue = Venue.find(params[:venue_id]) if params[:venue_id].present?
  end

  def set_field
    @field = Field.find(params[:field_id])
  end  

  def set_booking
    @booking = Booking.find(params[:id]) # Ini untuk show, edit, update, destroy
  end

  def booking_params
    params.require(:booking).permit(:user_id, :check_in_date, :check_out_date, :amount, :booking_status)
  end
end
