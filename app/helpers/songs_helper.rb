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

module SongsHelper
end
