class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_dark_mode_class

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end
  
  def set_dark_mode_class
    if user_signed_in?
      current_user.reload
      @dark_mode = current_user.dark_mode
    else
      @dark_mode = false
    end
  end

  def switch_locale
    session[:locale] = params[:locale]
    redirect_back(fallback_location: root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birth_date, :street_address, :city, :postal_code, :country, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :birth_date, :street_address, :city, :postal_code, :country, :photo])
  end
end
