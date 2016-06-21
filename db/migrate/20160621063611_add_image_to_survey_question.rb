class AddImageToSurveyQuestion < ActiveRecord::Migration
  def change
    add_attachment :survey_questions, :image
  end
end
