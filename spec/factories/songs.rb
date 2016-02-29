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

FactoryGirl.define do
  factory :song do
    song_spotify_id "4VqPOruhp5EdPBeR92t6lQ"
    song_spotify_url "spotify:track:4VqPOruhp5EdPBeR92t6lQ"
    name "Uprising"
    preview_url "https://p.scdn.co/mp3-preview/104ad0ea32356b9f3b2e95a8610f504c90b0026"
    album_cover_url "https://i.scdn.co/image/4ca55ab16f598335b52c9f2103708042d85e2ad2"
    album_name "The resistance" 
    duration 304840
    artist_name "Muse"
    artist_spotify_id "12Chz98pHFMPJEknJQMWvI"
    echonest_song_type ["studio", "electric", "vocal"]
    echonest_key 2
    echonest_energy 0.904546
    echonest_liveness 0.117365
    echonest_tempo  0.117365
    echonest_speechiness 0.117365
    echonest_acousticness 0.117365
    echonest_instrumentalness 0.117365
    echonest_mode 1
    echonest_time_signature 4
    echonest_loudness -4.046
    echonest_valence 0.436083
    echonest_danceability 0.601529
  end
end
