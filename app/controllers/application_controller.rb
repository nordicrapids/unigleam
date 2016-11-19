class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def authorize_admin
		unless (user_signed_in? and (current_user.is_admin == true))
      redirect_to root_path
    end
  end

protected
    def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :first_name, :last_name, :age, :address, :password, :password_confirmation) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:password, :password_confirmation, :current_password) }
    end
end
