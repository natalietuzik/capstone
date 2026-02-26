class JournalEntriesController < ApplicationController
  before_action :require_login
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @journal_entries = current_user.journal_entries.ordered
  end

  def show
  end

  def new
    @journal_entry = current_user.journal_entries.build(date: Date.today)
  end

  def create
    @journal_entry = current_user.journal_entries.build(journal_entry_params)
    if @journal_entry.save
      flash[:notice] = "Journal entry saved."
      redirect_to journal_entries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @journal_entry.update(journal_entry_params)
      flash[:notice] = "Journal entry updated."
      redirect_to journal_entry_path(@journal_entry)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @journal_entry.destroy
    flash[:notice] = "Journal entry deleted."
    redirect_to journal_entries_path
  end

  private

  def set_entry
    @journal_entry = current_user.journal_entries.find(params[:id])
  end

  def journal_entry_params
    params.require(:journal_entry).permit(:date, :title, :body)
  end
end
