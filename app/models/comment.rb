class Comment < ActiveRecord::Base
  belongs_to :survey_question
  belongs_to :user
end
