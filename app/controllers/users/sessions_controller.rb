class Users::SessionsController < ApplicationController

  def new
    redirect_to root_path
  end

  def create
    @status = false
    resource = User.find_for_database_authentication(email: params[:user][:email])

    if resource.valid_password?(params[:user][:password])
      sign_in :user, resource
      @status = true
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to root_path

  end


end
