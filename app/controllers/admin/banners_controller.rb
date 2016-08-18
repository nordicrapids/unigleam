class Admin::BannersController < ApplicationController
layout "admin"
before_action :authenticate_user!
before_filter :authorize_admin
  
  def index
    if Banner.first.blank?
      @banner = Banner.create!    
    end
    @banner = Banner.first
  end

  def update
    @banner = Banner.first
    if (@banner.update_attributes(banner_params))
      flash[:notice] = "Banner has been updated."
      redirect_to admin_banner_path
    else
      flash[:alert] = "Banner has not been updated."
      render "index"
    end
  end

private
    def banner_params
      columns = Banner.strong_parameters
      params.require(:banner)
      .permit(columns)
    end

end
