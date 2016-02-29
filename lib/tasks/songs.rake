namespace :songs do
  desc "populate"
  task :populate => :environment do
    File.open("song_databases/unique_tracks.txt", "r") do |f|
      f.each_line do |line|
        Song.register_from_echonest(line.split('<SEP>')[1])
      end
    end
    #puts "hey"
  end
end
