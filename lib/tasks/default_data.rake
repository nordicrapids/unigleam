namespace :unigleam do

  desc "Delete all Comment"
  task :delete_all_comment => :environment do
    Comment.all.each do |comment|
      comment.destroy
    end
    puts '----------------- all comments deleted ---------------------------------'
  end

  desc "Delete all normal user"
  task :delete_all_normal_user => :environment do
    User.all.each do |user|
      if user.is_admin.eql?(false)
        user.destroy
      end
    end
    puts '----------------- all normal user deleted ---------------------------------'
  end

end
