class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # Override edit to work with custom routes
  def edit
    super
  end
  
  # Override update to work with custom routes
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    
    if resource_updated
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message_for_update(resource, prev_unconfirmed_email)
      end
      
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
  
  protected
  
  # Override after_update_path to redirect to profile with username
  def after_update_path_for(resource)
    user_profile_path(resource.username)
  end
  
  # Permit additional parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birth_date, :street_address, :city, :postal_code, :country, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :birth_date, :street_address, :city, :postal_code, :country, :photo])
  end
  
  # Get account update params
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :birth_date, :street_address, :city, :postal_code, :country, :photo, :password, :password_confirmation, :current_password)
  end
  
  # Update resource with or without password
  def update_resource(resource, params)
    # If password is blank, update without password
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
      params.delete(:current_password)
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end
