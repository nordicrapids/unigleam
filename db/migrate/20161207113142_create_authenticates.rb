class CreateAuthenticates < ActiveRecord::Migration
  def change
    create_table :authenticates do |t|
      t.integer :user_id
    	t.string   :uid
    	t.string   :token
    	t.text     :refresh_token
    	t.string   :provider
    	t.string   :image_url
    	t.string   :expires_at
    	t.boolean  :expires,       default: false
    	t.text     :profile
    	t.text     :profile_image
    	t.string   :gender
    	t.text     :access_token
      t.timestamps null: false
    end
  end
end
