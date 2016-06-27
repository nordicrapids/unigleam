class AddSlugToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :slug, :string, :unique => true
  end
end
