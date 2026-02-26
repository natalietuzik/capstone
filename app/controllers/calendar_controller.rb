class CalendarController < ApplicationController
  before_action :require_login

  def index
    @year = params[:year]&.to_i || Date.today.year
    @month = params[:month]&.to_i || Date.today.month
    @current_month = Date.new(@year, @month, 1)
    @prev_month = @current_month.prev_month
    @next_month = @current_month.next_month

    @start_date = @current_month.beginning_of_week(:sunday)
    @end_date = @current_month.end_of_month.end_of_week(:sunday)

    @planner_items = current_user.planner_items
                                  .where(date: @start_date..@end_date)
                                  .group_by(&:date)
    @mental_health_entries = current_user.mental_health_entries
                                          .where(date: @start_date..@end_date)
                                          .index_by(&:date)
    @medication_logs = current_user.medication_logs
                                    .where(date: @start_date..@end_date)
                                    .group_by(&:date)

    if params[:selected_date]
      @selected_date = Date.parse(params[:selected_date])
      @day_planner_items = current_user.planner_items.for_date(@selected_date).ordered
      @day_mental_health = current_user.mental_health_entries.find_by(date: @selected_date)
      @day_med_logs = current_user.medication_logs.where(date: @selected_date).includes(:medication)
    end
  end
end
