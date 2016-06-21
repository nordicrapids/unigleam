class AddImageToSurveyQuestion < ActiveRecord::Migration
  def change
    add_attachment :survey_questions, :image
    add_column :survey_questions, :slug, :string
  end
end
