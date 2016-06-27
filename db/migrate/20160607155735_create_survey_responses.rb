class CreateSurveyResponses < ActiveRecord::Migration
  def change
    create_table :survey_responses do |t|
      t.references :user, index: true
      t.references :survey_question, index: true
      t.text       :answer
      t.timestamps
    end
  end
end
