class UsersController < ApplicationController
  before_action :authenticate_user!
  
  # GET request to /users/
  def index
    @users = User.includes(:profile)
  end
  
  # GET request to /users/:id
  def show
    @user = User.find( params[:id] )
  end
end