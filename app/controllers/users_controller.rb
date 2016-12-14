class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ ]

  def index
    @users = User.all
    render :layout => 'admin'
  end

  def edit
    if params[:type].present?
      @user = User.find(params[:id])
      render :layout => 'admin'
    else
      @user = current_user
      render :layout => 'user'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      @user.save!
      flash[:notice] = 'Profile Updated Successfully'

      if params[:type].present?
        if params[:current].present?
          redirect_to admin_root_path
        else
          redirect_to users_path
        end
      else
        redirect_to dashboard_path
      end
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
