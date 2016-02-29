class SongApi
  def self.get_song_from_apis(id,echonest_id=nil,song_profile=nil)
    song_spotify_info = RSpotify::Track.find(id)
    url = "spotify:track:#{id}"
    if song_profile
      song_echonest_info = song_profile
    else
      song_echonest_info = Echowrap.song_profile(track_id: url,bucket: ['audio_summary','song_type'])
    end
    if song_spotify_info.album.images.any?
      album_cover = song_spotify_info.album.images.first['url']
    else
      album_cover = nil
    end
    if song_echonest_info
      current_song = Song.create(echonest_id:echonest_id, song_spotify_id: id, song_spotify_url: url, name: song_spotify_info.name, preview_url: song_spotify_info.preview_url,
        album_name: song_spotify_info.album.name, album_cover_url: album_cover, duration: song_spotify_info.duration_ms,
         artist_name: song_spotify_info.artists.first.name, artist_spotify_id: song_spotify_info.artists.first.id, echonest_song_type: song_echonest_info.song_type,
         echonest_key: song_echonest_info.audio_summary.key, echonest_energy: song_echonest_info.audio_summary.energy, echonest_liveness: song_echonest_info.audio_summary.liveness,
         echonest_tempo: song_echonest_info.audio_summary.tempo , echonest_speechiness: song_echonest_info.audio_summary.speechiness, echonest_acousticness: song_echonest_info.audio_summary.acousticness,
         echonest_instrumentalness: song_echonest_info.audio_summary.instrumentalness, echonest_mode: song_echonest_info.audio_summary.mode,
         echonest_time_signature: song_echonest_info.audio_summary.time_signature, echonest_loudness: song_echonest_info.audio_summary.loudness,
         echonest_valence: song_echonest_info.audio_summary.valence, echonest_danceability: song_echonest_info.audio_summary.danceability )
    else
       current_song = Song.create(song_spotify_id: id, song_spotify_url: url, name: song_spotify_info.name, preview_url: song_spotify_info.preview_url,
        album_name: song_spotify_info.album.name, album_cover_url: album_cover, duration: song_spotify_info.duration_ms,
         artist_name: song_spotify_info.artists.first.name, artist_spotify_id: song_spotify_info.artists.first.id )
    end
    return current_song
  end
end