class Client::FieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_field, only: %i[ show edit update destroy ]

  # GET /fields or /fields.json
  def index
    @fields = Field.all
    @cities = Field.select(:city).where(city: ['Jakarta', 'Bandung', 'Surabaya', 'Yogyakarta', 'Semarang']).distinct.pluck(:city)
    @field_types = ['Mini Soccer', 'Futsal']
    
    if params[:query].present?
      @fields_name = Field.where('name LIKE ?', "%#{params[:query][:name]}%") if params[:query][:name].present?
      @fields_city = Field.where(city: params[:query][:city]) if params[:query][:city].present?
      @fields_type = Field.where(field_type: params[:query][:field_type]) if params[:query][:field_type].present?
    end
      # Logika untuk filter berdasarkan tanggal
      # Anda perlu menyesuaikan dengan bagaimana field menyimpan data ketersediaan
      # Pagination logic
  page = params[:page] || 1
  per_page = 10
  @fields = @fields.paginate(page: page, per_page: per_page)

  # Optional: Calculate total number of pages
  @total_pages = (@fields.size / per_page.to_f).ceil
  end

  # GET /fields/1 or /fields/1.json
  def show
   
  end

  # GET /fields/new
  def new
    @field = Field.new
    @cities = ["Jakarta", "Bandung", "Surabaya", "Yogyakarta", "Semarang"] # Contoh kota di Pulau Jawa
  end

  # GET /fields/1/edit
  def edit
  end

  # POST /fields or /fields.json
  def create

    @field = Field.new(field_params)
    @cities = ["Jakarta", "Bandung", "Surabaya", "Yogyakarta", "Semarang"] # Ini juga perlu jika `create` gagal dan kembali ke `new`
    @field.user_id = current_user.id
    respond_to do |format|
      if @field.save
        format.html { redirect_to client_field_path(@field), notice: 'Field was successfully created.' }
        format.json { render :show, status: :created, location: @field }
        return
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end    
  end

  # PATCH/PUT /fields/1 or /fields/1.json
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

  # DELETE /fields/1 or /fields/1.json
  def destroy
    @field.destroy!

    respond_to do |format|
      format.html { redirect_to client_fields_url, notice: "Field was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_field
      @field = Field.find_by(id: params[:id], user_id: current_user.id)
      if @field.nil?
        redirect_to client_fields_path, alert: "Field not found"
      end
    end
    

    # Only allow a list of trusted parameters through.
    def field_params
      params.require(:field).permit(:name, :address, :date, :city, :image, :field_type, :price, :capacity, :description, :created_at, :updated_at)
    end
end
