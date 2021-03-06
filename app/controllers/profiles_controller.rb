class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  
  
  # GET to /users/:user_id/profile/new
  def new 
    # Render blank profile details form
    @profile = Profile.new
  end

  # POST to /users/:.user_id/profile 
  def create
    # Ensure that we have the user id for user filling out form
    @user = User.find( params[:user_id] )
    # Create profile linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path(id: params[:user_id] )
    else
      render action: :new
    end
  end
  
  # GET to /users/:user_id/profile/edit
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  # PUT/PATCH to /users/:user_id/profile
  def update
    # Retrieve the user from the database
    @user = User.find( params[:user_id] )
    # Retrieve the User profile
    @profile = @user.profile
    # Mass assign profile attributes and save
    if @profile.update_attributes( profile_params )
      flash[:success] = "Profile updated"
      # Redirect user to their profile page
      redirect_to user_path(id: params[:user_id])
    else
      render action: :edit
    end
  end
  
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find( params[:user_id] )
      if current_user.profile
        redirect_to(edit_user_profile_path(user_id: current_user.id)) unless @user == current_user
      else
        redirect_to(new_user_profile_path(user_id: current_user.id)) unless @user == current_user
      end
    end
end
