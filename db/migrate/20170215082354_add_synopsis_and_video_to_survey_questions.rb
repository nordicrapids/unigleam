class AddSynopsisAndVideoToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :synopsis, :text
    add_attachment :survey_questions, :video
  end
end
