class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ ]
  layout 'user', only: [:edit, :update]
  def index
  end

  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      current_user.save!
      flash[:notice] = 'Profile Updated Successfully'
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def follow_user
    check_user_follow = UserFollow.check_following(params[:follow_id].to_i,current_user.id)
    unless check_user_follow.present?
      @user_follow = UserFollow.create(user_id: params[:follow_id], follow_id: current_user.id )
    else
        check_user_follow.delete_all
    end
  end

  def destroy

  end

  private

    def user_params
      params.require(:user).permit(:id, :email, :username, :first_name, :last_name, :age, :address, :profile_image, :city, :gender, :latitude, :longitude, :provider, :uid, :is_admin )
    end
end
