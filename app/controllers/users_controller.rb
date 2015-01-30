class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  respond_to :html

  # GET /users
  def index
    @users = User.page(params[:page]).order("created_at DESC")
    @user_count = User.count
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end  

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], as: current_user.role.to_sym)
      flash[:notice] = 'User was successfully updated.'
    end  
    respond_with(@user)
  end
end
