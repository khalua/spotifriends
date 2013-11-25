class EntriesController < ApplicationController
  load_and_authorize_resource
  before_filter :check_if_logged_in

  def index
    @entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def new
    @entry = Entry.new
  end

  def edit
    @entry = Entry.find(params[:id])
    render :new
  end

  def create
    @entry = Entry.new(params[:entry])
    if @entry.save
      redirect_to(entry)
    else
      render :new
    end
  end

  def update
    @entry = Entry.find(params[:id])
    @entry.update_attributes(params[:entry])
    redirect_to(entries_path)
  end


  def destroy
  end

end