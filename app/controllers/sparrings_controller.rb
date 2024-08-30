class SparringsController < ApplicationController
  before_action :set_sparring, only: %i[ show ]

  # GET /sparrings or /sparrings.json
  def index
    @sparrings = Sparring.all
    puts @sparrings.inspect
  end

  # GET /sparrings/1 or /sparrings/1.json
  def show
  end

  # GET /sparrings/new
  def new
    @sparring = Sparring.new
  end

  # GET /sparrings/1/edit
  def edit
  end

  # POST /sparrings or /sparrings.json
  def create
    @sparring = Sparring.new(sparring_params)

    respond_to do |format|
      if @sparring.save
        format.html { redirect_to sparring_url(@sparring), notice: "Sparring was successfully created." }
        format.json { render :show, status: :created, location: @sparring }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sparring.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sparrings/1 or /sparrings/1.json
  def update
    respond_to do |format|
      if @sparring.update(sparring_params)
        format.html { redirect_to sparring_url(@sparring), notice: "Sparring was successfully updated." }
        format.json { render :show, status: :ok, location: @sparring }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sparring.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sparrings/1 or /sparrings/1.json
  def destroy
    @sparring.destroy!

    respond_to do |format|
      format.html { redirect_to sparrings_url, notice: "Sparring was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sparring
      @sparring = Sparring.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sparring_params
      params.fetch(:sparring, {})
    end
end
