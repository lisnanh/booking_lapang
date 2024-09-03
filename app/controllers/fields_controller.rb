class FieldsController < ApplicationController
  before_action :set_field, only: %i[ show ]

  # GET /fields or /fields.json
  def index
    @fields = Field.all
    puts @fields.inspect

    if params[:venue_name].present?
      @fields = @fields.where("name ILIKE ?", "%#{params[:venue_name]}%")
    end

    if params[:location].present? && params[:location] != "all"
      @fields = @fields.where(location: params[:location])
    end

    if params[:type].present? && params[:type] != "all"
      @fields = @fields.where(field_type: params[:type])
    end

    if params[:date].present?
      # Logika untuk filter berdasarkan tanggal
      # Anda perlu menyesuaikan dengan bagaimana field menyimpan data ketersediaan
    end
  end

  # GET /fields/1 or /fields/1.json
  def show
  end

  # GET /fields/new
  def new
    @field = Field.new
  end

  # GET /fields/1/edit
  def edit
  end

  # POST /fields or /fields.json
  def create
  @field = Field.new(field_params)

    respond_to do |format|
      if @field.save
        Rails.logger.info "Image uploaded: #{@field.image_url.attached?}"
        format.html { redirect_to field_url(@field), notice: "Field was successfully created." }
        format.json { render :show, status: :created, location: @field }
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
        format.html { redirect_to field_url(@field), notice: "Field was successfully updated." }
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
      format.html { redirect_to fields_url, notice: "Field was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_field
      @field = Field.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def field_params
      params.require(:field).permit(:name, :address, :price, :created_at, :image_url)
    end
end
