class Client::ManagementFieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_management_field, only: [:edit, :update, :destroy]
  before_action :set_field, only: [:new, :create]
  before_action :set_venue, only: [:index, :show, :edit, :update, :destroy]
  
  def index
    @venues = current_user.venues.includes(:fields)
    @management_fields = ManagementField.where(venue_id: @venue.id)

    if current_user.present?
      # Hanya tampilkan field yang dimiliki oleh current user melalui venue
      @management_fields = current_user.fields.includes(:venue)
    end
  
    # Filter by name if present
    if params[:query]&.dig(:name).present?
      @fields = @fields.where('name ILIKE ?', "%#{params[:query][:name]}%")
    end
  
    # Filter by city if present
    if params[:query]&.dig(:city).present?
      @fields = @fields.where(city: params[:query][:city])
    end
  
    # Filter by field_type if present
    if params[:query]&.dig(:field_type).present?
      @fields = @fields.where(field_type: params[:query][:field_type])
    end
  end

  def show
    @field = Field.find(params[:id])  # Pastikan Anda mengambil data Field dengan benar
  end

  def new
    @management_field = current_user.management_fields.new
  end

  def create
    @field = Field.new(field_params)
    if @field.save
      redirect_to client_venue_management_fields_path(venue_id: @field.venue_id), notice: 'Field berhasil ditambahkan.'
    else
      render :new # Tampilkan form dengan error
    end
    @management_field = current_user.management_fields.new(management_field_params)
    if @management_field.save
      redirect_to client_management_fields_path, notice: 'Management field was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @management_field.update(management_field_params)
      redirect_to client_management_fields_path, notice: 'Management field was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @management_field.destroy
    redirect_to client_management_fields_path, notice: 'Management field was successfully deleted.'
  end

  private

  def set_venue
    @venue = Venue.find(params[:venue_id]) # Pastikan venue_id ada dalam params
  rescue ActiveRecord::RecordNotFound
    redirect_to client_venues_path, alert: "Venue tidak ditemukan."
  end

  def set_field
    @field = Field.find(params[:field_id])
  end

  def set_management_field
    @management_field = current_user.management_fields.find(params[:id])
  end

  def management_field_params
    params.require(:management_field).permit(:name, :value)
  end
end
