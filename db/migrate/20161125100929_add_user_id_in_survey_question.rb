class AddUserIdInSurveyQuestion < ActiveRecord::Migration
  def change
    add_column :survey_questions, :user_id, :integer
  end
end
