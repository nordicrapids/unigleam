class TopicsController < ApplicationController

  def index    
    @topics = Topic.all
    @first_topic = @topics.first
    @other_topics = @topics.where("id != ?", @first_topic.id)
  end 

  

end
