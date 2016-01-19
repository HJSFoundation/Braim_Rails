require 'elasticsearch/persistence/model'
class Song
  include Elasticsearch::Persistence::Model

  index_name "braim"
  attribute :song_spotify_id , String , mapping: {analyzer: "4VqPOruhp5EdPBeR92t6lQ"}
  attribute :song_spotify_url, String, mapping: {analyzer: "spotify:track:4VqPOruhp5EdPBeR92t6lQ"}
  attribute :name,  String, mapping: { analyzer: 'Uprising' }
  attribute :preview_url,  String, mapping: { analyzer: 'https://p.scdn.co/mp3-preview/104ad0ea32356b9f3b2e95a8610f504c90b0026b' }
  attribute :album_cover_url,  String, mapping: { analyzer: 'https://i.scdn.co/image/4ca55ab16f598335b52c9f2103708042d85e2ad2' }
  attribute :album_name,  String, mapping: { analyzer: 'The Resistance' }
  attribute :duration, Integer , mapping: {analyzer: 304840}
  attribute :artist_name, String, mapping: {analyzer: "Muse"}
  attribute :artist_spotify_id, String, mapping: {analyzer: "12Chz98pHFMPJEknJQMWvI"}

  attribute :echonest_song_type, Array, mapping: {analyzer: ["studio", "electric", "vocal"]}
  attribute :echonest_key, Integer, mapping: {analyzer: 2}
  attribute :echonest_energy, Float, mapping: {analyzer: 0.904546}
  attribute :echonest_liveness, Float, mapping: {analyzer: 0.117365}
  attribute :echonest_tempo, Float, mapping: {analyzer: 0.117365}
  attribute :echonest_speechiness, Float, mapping: {analyzer: 0.117365}
  attribute :echonest_acousticness, Float, mapping: {analyzer: 0.117365}
  attribute :echonest_instrumentalness, Float, mapping: {analyzer: 0.117365}
  attribute :echonest_mode, Integer, mapping: {analyzer: 1}
  attribute :echonest_time_signature, Integer, mapping: {analyzer: 4}
  attribute :echonest_loudness, Float, mapping: {analyzer: -4.046}
  attribute :echonest_valence, Float, mapping: {analyzer: 0.436083}
  attribute :echonest_danceability, Float, mapping: {analyzer: 0.601529}

  def self.get_info(id)
    current_song = (search query: { match: { song_spotify_id: id  } }).results
    if current_song.any?
      return current_song[0]
    else
      song_spotify_info = RSpotify::Track.find(id)
      url = "spotify:track:#{id}"
      song_echonest_info = Echowrap.song_profile(track_id: url,bucket: ['audio_summary','song_type'])
      
      if song_spotify_info.album.images.any?
        album_cover = song_spotify_info.album.images.first['url']
      else
        album_cover = nil
      end

      
      current_song = create(song_spotify_id: id, song_spotify_url: url, name: song_spotify_info.name, preview_url: song_spotify_info.preview_url,
        album_name: song_spotify_info.album.name, album_cover_url: album_cover, duration: song_spotify_info.duration_ms,
         artist_name: song_spotify_info.artists.first.name, artist_spotify_id: song_spotify_info.artists.first.id, echonest_song_type: song_echonest_info.song_type,
         echonest_key: song_echonest_info.audio_summary.key, echonest_energy: song_echonest_info.audio_summary.energy, echonest_liveness: song_echonest_info.audio_summary.liveness,
         echonest_tempo: song_echonest_info.audio_summary.tempo , echonest_speechiness: song_echonest_info.audio_summary.speechiness, echonest_acousticness: song_echonest_info.audio_summary.acousticness,
         echonest_instrumentalness: song_echonest_info.audio_summary.instrumentalness, echonest_mode: song_echonest_info.audio_summary.mode,
         echonest_time_signature: song_echonest_info.audio_summary.time_signature, echonest_loudness: song_echonest_info.audio_summary.loudness,
         echonest_valence: song_echonest_info.audio_summary.valence, echonest_danceability: song_echonest_info.audio_summary.danceability )
      #byebug
      #puts ""
      return current_song
    end
  end
 
end