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
    @user_follow = UserFollow.find_by_user_id_and_follow_id(params[:follow_id], current_user.id)
    if @user_follow.present?
      # @user_follow.destroy
    else
      @user_follow = UserFollow.create(user_id: params[:follow_id], follow_id: current_user.id)
    end
  end

  def destroy

  end

  private

    def user_params
      params.require(:user).permit(:id, :email, :first_name, :last_name, :age, :address, :profile_image, :city, :gender, :latitude, :longitude, :provider, :uid, :is_admin )
    end
end
