class Admin::TopicsController < ApplicationController
layout "admin"
before_action :authenticate_user!

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(topic_params)
    if (@topic.save)
      flash[:notice] = "Topic has been created."
      redirect_to admin_topics_path
    else
      flash[:alert] = "Topic has not been created. #{@topic.errors.full_messages.to_sentence}"
      render "new"
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if (@topic.update_attributes(topic_params))
      flash[:notice] = "Topic has been updated."
      redirect_to admin_topics_path
    else
      flash[:alert] = "Topic not been updated."
      render "edit"
    end
  end

private
    def topic_params
      columns = Topic.strong_parameters
      params.require(:topic)
      .permit(columns)
    end

end
