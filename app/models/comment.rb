class Comment < ActiveRecord::Base
  belongs_to :survey_question
end
