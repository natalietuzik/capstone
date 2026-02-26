class DashboardController < ApplicationController
  before_action :require_login

  def index
    @today = Date.today
    @todays_tasks = current_user.planner_items.for_date(@today).ordered
    @medications = current_user.medications.includes(:medication_logs)
    @todays_mental_health = current_user.mental_health_entries.find_by(date: @today)
    @todays_med_logs = current_user.medication_logs.where(date: @today).includes(:medication)
  end
end
