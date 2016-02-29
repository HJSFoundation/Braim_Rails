# == Schema Information
#
# Table name: songs
#
#  id                        :integer          not null, primary key
#  song_spotify_id           :string
#  song_spotify_url          :string
#  name                      :string
#  preview_url               :string
#  album_cover_url           :string
#  album_name                :string
#  duration                  :integer
#  artist_name               :string
#  artist_spotify_id         :string
#  echonest_song_type        :string           is an Array
#  echonest_key              :integer
#  echonest_energy           :float
#  echonest_liveness         :float
#  echonest_tempo            :float
#  echonest_speechiness      :float
#  echonest_acousticness     :float
#  echonest_instrumentalness :float
#  echonest_mode             :integer
#  echonest_time_signature   :integer
#  echonest_loudness         :float
#  echonest_valence          :float
#  echonest_danceability     :float
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  echonest_id               :string
#

class Song < ActiveRecord::Base
  has_many :ratings
  has_many :users, :through => :ratings
  has_many :recordings
  
  def last_recording
    recordings.last
  end
  
  def self.songs_to_discover(user)
    recordings = Recording.all_except(user)
    songs = recordings.collect{|r| r.song}
    discover_songs = songs.uniq
    user_recordings = user.recordings
    user_songs = user_recordings.collect{|r| r.song}
    user_songs.each do |user_song| 
      discover_songs.delete_if {|song| song == user_song}
    end
    discover_songs
  end
  def self.register_from_echonest(echonest_id)
    song = Song.find_by(echonest_id: echonest_id)
    if song == nil 
      song_profile = Echowrap.song_profile(id:echonest_id, bucket: ['id:spotify','tracks','audio_summary','song_type'],limit:true)
      if song_profile
        new_song_id = song_profile.tracks[0].foreign_id.split('spotify:track:')[1]
        Song.find_or_register(new_song_id,echonest_id,song_profile)
      end
    end
  end
  def self.find_or_register(query_id,echonest_id=nil,song_profile=nil)
    song = Song.find_by(song_spotify_id: query_id)
    if song
      return song
    else
      song = SongApi.get_song_from_apis(query_id,echonest_id,song_profile)
      song.save_prediction_info
      return song
    end
  end
   def get_rating(current_user)
    rating = ratings.find_by(user: current_user)
    if rating 
      return rating.value
    else
      return 0
    end
  end
  def save_prediction_info
    song_info = self.attributes
    song_info.delete('id')
    request = PioClient.create_event(
      '$set',
      'item',
      self.id,
      { 'properties' => song_info.stringify_keys}
    )
    return JSON.parse(request.body)['eventId']
  end
end
