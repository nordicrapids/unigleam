class AddStatusToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :status, :string
  end
end
