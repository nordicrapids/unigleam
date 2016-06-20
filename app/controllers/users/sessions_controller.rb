class Users::SessionsController < ApplicationController

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])

    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in :user, resource
      return render :json => {:success => true}
    else
      invalid_login_attempt
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to root_path

  end

private
    def invalid_login_attempt
      return render :json => {:success => false}
    end

end
