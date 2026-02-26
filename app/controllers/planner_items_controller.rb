class PlannerItemsController < ApplicationController
  before_action :require_login
  before_action :set_planner_item, only: [ :show, :edit, :update, :destroy ]

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @planner_items = current_user.planner_items.for_date(@date).ordered
    @todo_items = current_user.todo_items.ordered
  end

  def show
  end

  def new
    @planner_item = current_user.planner_items.build(date: params[:date] || Date.today)
  end

  def create
    @planner_item = current_user.planner_items.build(planner_item_params)
    if @planner_item.save
      flash[:notice] = "Task created successfully."
      redirect_to planner_items_path(date: @planner_item.date)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @planner_item.update(planner_item_params)
      flash[:notice] = "Task updated successfully."
      redirect_to planner_items_path(date: @planner_item.date)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    date = @planner_item.date
    @planner_item.destroy
    flash[:notice] = "Task deleted."
    redirect_to planner_items_path(date: date)
  end

  private

  def set_planner_item
    @planner_item = current_user.planner_items.find(params[:id])
  end

  def planner_item_params
    params.require(:planner_item).permit(:date, :time_of_day, :title, :notes, :completed)
  end
end
