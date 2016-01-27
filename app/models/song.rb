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
#

class Song < ActiveRecord::Base
  has_many :ratings
  has_many :users, :through => :ratings
  has_many :recordings
  def self.find_or_register(query_id)
    song = Song.find_by(song_spotify_id: query_id)
    if song
      return song
    else
      song = SongApi.get_song_from_apis(query_id)
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
    request = PioClient.new_client.create_event(
      '$set',
      'item',
      self.id,
      { 'properties' => song_info.stringify_keys}
    )
    return JSON.parse(request.body)['eventId']
  end
end
