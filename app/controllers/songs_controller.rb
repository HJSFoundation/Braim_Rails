require 'rspotify'
class SongsController < ApplicationController
  before_action :authenticate_user!
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

  def rate
    id = params[:song_id]
    value = params[:rating]
    Song.update_rating(id,current_user.id,value)
    respond_to do |format|
      format.any { render json: {response: 'ok',rating: value}, content_type: 'application/json' }
    end
  end

  def show
    @song = Song.get_info(params[:id])
    @user = current_user
    @rating =@song.get_rating(@user.id)
    #byebug
    @recordings = Recording.all query: {bool: { must: [{ match: { user_id: @user.id}},{match: {song_id: @song.song_spotify_id}}]}},sort: [
      {date: {order: "desc", mode: "avg"}}]
    #@recordings = Recording.all_query(1,5,@user.id,@song.song_spotify_id)
  end

  def deal
    respond_to do |format|
      format.any { render json: {response: 'ok','License' => "EEG"}, content_type: 'application/json' }
    end
  end
end
