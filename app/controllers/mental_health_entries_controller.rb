class MentalHealthEntriesController < ApplicationController
  before_action :require_login
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entries = current_user.mental_health_entries.order(date: :desc)
  end

  def show
  end

  def new
    @entry = current_user.mental_health_entries.build(date: params[:date] || Date.today)
  end

  def create
    @entry = current_user.mental_health_entries.build(entry_params)
    if @entry.save
      flash[:notice] = "Entry saved."
      redirect_to mental_health_entries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      flash[:notice] = "Entry updated."
      redirect_to mental_health_entries_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    flash[:notice] = "Entry deleted."
    redirect_to mental_health_entries_path
  end

  private

  def set_entry
    @entry = current_user.mental_health_entries.find(params[:id])
  end

  def entry_params
    params.require(:mental_health_entry).permit(:date, :mood, :anxiety, :sleep_hours, :journal)
  end
end
