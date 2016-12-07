class Users::OmniauthCallbacksController < ApplicationController

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # orignal code
    # @user = User.from_omniauth(request.env["omniauth.auth"])
    # if @user.persisted?
    #   sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    # else
    #   session["devise.facebook_data"] = request.env["omniauth.auth"]
    #   redirect_to new_user_registration_url
    # end
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Facebook'
      sign_in(user)
      redirect_to root_path
    else
      session['devise.facebook_data'] = request.env['omniauth.auth'].except('extra')
      flash[:danger] = "Sorry, we couldn't get your enough information. Please go through required fields here."
      redirect_to new_user_registration_url
    end

  end

  def failure
    redirect_to root_path
  end

end
