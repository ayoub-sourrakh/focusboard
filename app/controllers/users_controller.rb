class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def profile
    @user = User.find_by!(username: params[:username])
    
    # Redirect to own profile if trying to access another user's profile
    if @user != current_user
      redirect_to user_profile_path(current_user.username), alert: "You can only view your own profile."
    end
  end
end
