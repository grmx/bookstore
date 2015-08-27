class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

  helper_method :current_order

  def current_order
    current_user.orders.in_progress.first_or_create
  end

  protected

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:warning] = "#{params[:locale]} translation not available"
        logger.error flash.now[:warning]
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation,
        :remember_me, :avatar, :avatar_cache, :remove_avatar)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation,
        :current_password, :avatar, :avatar_cache, :remove_avatar)
    end
  end
end
