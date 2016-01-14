require 'rspotify'
class SongsController < ApplicationController
  def search
    if params[:query]
      #@songs =  Echowrap.song_search(title: params[:query], results:20, bucket: 'song_type', sort: "artist_hotttnesss-desc")
      #@artists = Echowrap.artist_search(name: 'juanes', results:1, bucket: ['artist_location','images','genre'])
      @songs = RSpotify::Track.search(params[:query],limit:20)
      @artists = RSpotify::Artist.search(params[:query],limit:5)
    end
    respond_to do |format|
      format.html 
      format.js { render :template => '/songs/search'}
    end
  end

  def show
    @song = RSpotify::Track.find(params[:id])
    @song_spotify_url = "spotify:track:#{@song.id}"
    @song_echonest= Echowrap.song_profile(track_id: @song_spotify_url,bucket: ['audio_summary','song_type'])
    @user = current_user
  end

  def deal
    respond_to do |format|
      format.any { render json: {response: 'ok','License' => "EEG"}, content_type: 'application/json' }
    end
  end
end
