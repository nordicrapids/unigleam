class CreateSurveyQuestionAnswers < ActiveRecord::Migration
  def change
    create_table :survey_question_answers do |t|
      t.references :survey_question, index: true
      t.string     :answer
      t.integer    :position
      t.timestamps
    end
  end
end
