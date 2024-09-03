class Client::ManagementFieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_management_field, only: [:edit, :update, :destroy]

  def index
    @management_fields = current_user.management_fields
  end

  def new
    @management_field = current_user.management_fields.new
  end

  def create
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

  def set_management_field
    @management_field = current_user.management_fields.find(params[:id])
  end

  def management_field_params
    params.require(:management_field).permit(:name, :value)
  end
end
