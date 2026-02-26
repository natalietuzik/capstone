class MedicationsController < ApplicationController
  before_action :require_login
  before_action :set_medication, only: [:show, :edit, :update, :destroy]

  def index
    @medications = current_user.medications.order(:name)
  end

  def show
    @medication_logs = @medication.medication_logs.order(date: :desc).limit(30)
  end

  def new
    @medication = current_user.medications.build
  end

  def create
    @medication = current_user.medications.build(medication_params)
    if @medication.save
      flash[:notice] = "Medication added."
      redirect_to medications_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @medication.update(medication_params)
      flash[:notice] = "Medication updated."
      redirect_to medications_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @medication.destroy
    flash[:notice] = "Medication deleted."
    redirect_to medications_path
  end

  private

  def set_medication
    @medication = current_user.medications.find(params[:id])
  end

  def medication_params
    params.require(:medication).permit(:name, :dosage, :instructions)
  end
end
