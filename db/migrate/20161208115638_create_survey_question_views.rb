class CreateSurveyQuestionViews < ActiveRecord::Migration
  def change
    create_table :survey_question_views do |t|
      t.integer :user_id
      t.integer :survey_question_id

      t.timestamps null: false
    end
  end
end
