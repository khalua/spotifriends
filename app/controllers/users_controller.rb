class UsersController < ApplicationController
  load_and_authorize_resource
  # before_filter :check_if_logged_in, :except => [:new, :create, :request_account]

  def new
    @user = User.new
  end

  def edit
    @user = current_user
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(root_path)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:user])
  end

  def claim_account
    if current_user
      @user = current_user
      session[:token_url] = request.env["HTTP_REFERER"]
      sign_out current_user
      redirect_to new_password_path(@user)
    else
      redirect_to :back
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to(root_path)
    else
      render :new
    end
  end

  def request_account
  end
end
