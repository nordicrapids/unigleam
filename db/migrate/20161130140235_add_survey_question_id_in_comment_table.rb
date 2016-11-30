class AddSurveyQuestionIdInCommentTable < ActiveRecord::Migration
  def change
    add_column :comments, :survey_question_id, :integer
  end
end
