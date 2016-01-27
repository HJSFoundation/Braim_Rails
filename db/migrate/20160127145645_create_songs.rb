class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :song_spotify_id
      t.string :song_spotify_url
      t.string :name
      t.string :preview_url
      t.string :album_cover_url
      t.string :album_name
      t.integer :duration
      t.string :artist_name
      t.string :artist_spotify_id
      #
      t.string :echonest_song_type , array: true
      t.integer :echonest_key
      t.float :echonest_energy
      t.float :echonest_liveness
      t.float :echonest_tempo
      t.float :echonest_speechiness
      t.float :echonest_acousticness
      t.float :echonest_instrumentalness
      t.integer :echonest_mode
      t.integer :echonest_time_signature
      t.float :echonest_loudness
      t.float :echonest_valence
      t.float :echonest_danceability
      t.timestamps null: false
    end
  end
end
