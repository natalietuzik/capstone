class TodoItemsController < ApplicationController
  before_action :require_login
  before_action :set_todo_item, only: [:show, :edit, :update, :destroy]

  def index
    @todo_items = current_user.todo_items.ordered
  end

  def show
  end

  def new
    @todo_item = current_user.todo_items.build(priority: 2)
  end

  def create
    @todo_item = current_user.todo_items.build(todo_item_params)
    if @todo_item.save
      flash[:notice] = "To-do item added."
      redirect_to todo_items_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo_item.update(todo_item_params)
      flash[:notice] = "To-do item updated."
      redirect_to todo_items_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_item.destroy
    flash[:notice] = "To-do item deleted."
    redirect_to todo_items_path
  end

  private

  def set_todo_item
    @todo_item = current_user.todo_items.find(params[:id])
  end

  def todo_item_params
    params.require(:todo_item).permit(:title, :notes, :completed, :priority)
  end
end
