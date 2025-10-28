class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
  end
  
  def toggle_dark_mode
    current_user.update(dark_mode: !current_user.dark_mode)
    redirect_to settings_path, notice: t('settings.dark_mode.toggled')
  end
end
