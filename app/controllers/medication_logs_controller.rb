class MedicationLogsController < ApplicationController
  before_action :require_login
  before_action :set_medication, only: [:new, :create]
  before_action :set_medication_log, only: [:show, :edit, :update, :destroy]

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @medication_logs = current_user.medication_logs.where(date: @date).includes(:medication)
  end

  def show
  end

  def new
    @medication_log = @medication.medication_logs.build(date: Date.today, user: current_user)
  end

  def create
    @medication_log = current_user.medication_logs.build(medication_log_params)
    @medication_log.medication_id = params[:medication_id]
    if @medication_log.save
      flash[:notice] = "Medication log added."
      redirect_to medication_path(@medication_log.medication)
    else
      @medication = current_user.medications.find(params[:medication_id])
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @medication_log.update(medication_log_params)
      flash[:notice] = "Medication log updated."
      redirect_to medication_path(@medication_log.medication)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    medication = @medication_log.medication
    @medication_log.destroy
    flash[:notice] = "Log deleted."
    redirect_to medication_path(medication)
  end

  private

  def set_medication
    @medication = current_user.medications.find(params[:medication_id])
  end

  def set_medication_log
    @medication_log = current_user.medication_logs.find(params[:id])
  end

  def medication_log_params
    params.require(:medication_log).permit(:date, :taken, :time_taken, :notes, :medication_id)
  end
end
