class Users::SessionsController < ApplicationController

  def new
    redirect_to root_path
  end

  def create
    @status = false
    if params[:user][:email].include?('.co')
      resource = User.find_for_database_authentication(email: params[:user][:email])
    else
      resource = User.find_for_database_authentication(username: params[:user][:email])
    end

    if resource.valid_password?(params[:user][:password])
      sign_in :user, resource
      @status = true
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to root_path

  end

  def check_email
    @user = User.find_by_email(params[:user][:email]) || User.find_by_username(params[:user][:email])
    respond_to do |format|
     format.json { render :json => @user.present? }
    end
  end

  def check_email_registration
    if params[:user][:email].present?
      @user = User.find_by_email(params[:user][:email])
    elsif params[:user][:username]
      @user = User.find_by_username(params[:user][:username])
    end
    respond_to do |format|
     format.json { render :json => !@user.present? }
    end
  end

end
