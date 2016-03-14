namespace :prediction do
  desc "populate"
  task :populate => :environment do
    Song.all.each do |song|
      song.save_prediction_info
    end
    User.all.each do |user|
      user.save_prediction_info
    end
    Entry.all.each do |entry|
      entry.save_prediction_info
    end
    Rating.all.each do |rating|
      rating.save_prediction_info
    end
  end
end
