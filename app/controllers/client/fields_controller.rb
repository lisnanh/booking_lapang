class Client::FieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_field, only: %i[ show edit update destroy ]
  before_action :set_venue

  def index
    @fields = Field.all

    if params[:query]&.dig(:name).present?
      @fields = @fields.where('name ILIKE ?', "%#{params[:query][:name]}%")
    end

    if params[:query]&.dig(:city).present?
      @fields = @fields.where(city: params[:query][:city])
    end

    if params[:query]&.dig(:field_type).present?
      @fields = @fields.where(field_type: params[:query][:field_type])
    end

    @cities = Field.select(:city).where(city: ['Jakarta', 'Bandung', 'Surabaya', 'Yogyakarta', 'Semarang']).distinct.pluck(:city)
    @field_types = ['Mini Soccer', 'Futsal']
    
    page = params[:page] || 1
    per_page = 10
    @fields = @fields.paginate(page: page, per_page: per_page)
    @total_pages = (@fields.size / per_page.to_f).ceil
  end

  def show
    @venue = Venue.find(params[:venue_id])  # Pastikan venue_id ada di parameter
    @field = Field.find(params[:id])
    @bookings = @field.bookings
  end

  def new
    @field = @venue.fields.build
    @cities = ["Jakarta", "Bandung", "Surabaya", "Yogyakarta", "Semarang"]
  end

  def create
    @field = Field.new(field_params)
    @field = @venue.fields.build(field_params)
    @cities = ["Jakarta", "Bandung", "Surabaya", "Yogyakarta", "Semarang"]
    @field.user_id = current_user.id

    respond_to do |format|
      if @field.save
        format.html { redirect_to client_venue_fields_path(@venue), notice: 'Field was successfully created.' }
        format.json { render :show, status: :created, location: @field }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end    
  end

  def update
    respond_to do |format|
      if @field.update(field_params)
        format.html { redirect_to client_fields_url(@field), notice: "Field was successfully updated." }
        format.json { render :show, status: :ok, location: @field }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @field.destroy!
    respond_to do |format|
      format.html { redirect_to client_fields_url, notice: "Field was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_field
      @field = Field.find(params[:id])
      @field = Field.find_by(id: params[:id])
      if @field.nil?
        redirect_to client_fields_path, alert: "Field not found"
      end
    end
    
    def set_venue
      @venue = Venue.find_by(id: params[:venue_id])
      unless @venue
        redirect_to client_venues_path, alert: "Venue not found"
      end
    end

    def field_params
      params.require(:field).permit(:name, :address, :date, :city, :image, :field_type, :price, :capacity, :description, :created_at, :updated_at, :venue_id, :booking_id)
    end
end
