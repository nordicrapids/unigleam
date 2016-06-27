class CreateSurveyQuestions < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
      t.references :topic, index: true
      t.string     :title
      t.text       :answer_options
      t.integer    :share_counter 
      t.timestamps
    end
  end
end
