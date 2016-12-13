class Users::SessionsController < ApplicationController

  def new
    redirect_to root_path
  end

  def create
    @status = false
    if params[:user][:email].include?('.co')
      resource = User.find_for_database_authentication(email: params[:user][:email].downcase)
    else
      resource = User.find_for_database_authentication(username: params[:user][:email].downcase)
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
    @user = User.find_by_email(params[:user][:email].downcase) || User.find_by_username(params[:user][:email])
    respond_to do |format|
     format.json { render :json => @user.present? }
    end
  end

  def check_email_registration
    if params[:user][:email].present?
      @user = User.find_by_email(params[:user][:email].downcase)
    elsif params[:user][:username]
      @user = User.find_by_username(params[:user][:username])
    end
    respond_to do |format|
     format.json { render :json => !@user.present? }
    end
  end

  def check_username
    @user = User.find_by_username(params[:user][:username])
    @current_user = User.find(params[:id]) if params[:id].present?
    respond_to do |format|
      if @user.present? && @user.id == @current_user.id
        format.json { render :json => @user.present? }
      else
        format.json { render :json => !@user.present? }
      end
    end
  end

end
