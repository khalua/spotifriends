class ContestsController < ApplicationController
  load_and_authorize_resource

  def index
    @contests = current_user.contests
  end

  def show
    @contest = Contest.find(params[:id])
    @owner = User.find(@contest.admin_id)
  end

  def results
    @contest = Contest.find(params[:contest_id])
    @songs = @contest.songs
  end

  def new
    @contest = Contest.new
    @groups = current_user.groups
  end

  def create
    contest = Contest.new(params[:contest])
    contest.admin_id = current_user.id
    contest.save
    redirect_to (contests_path)
  end

  def add_group
    @group = Group.new
  end

  def create_group
    @group = Group.create(params[:group])
    current_user.groups << @group
    @contest = Contest.new
    @groups = current_user.groups
  end
end