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
    song = Song.find(id)
    current_rating = song.ratings.find_by(user: current_user)
    if current_rating
      current_rating.value = value
      current_rating.save
    else
      current_rating = song.ratings.create(user: current_user, value: value)
    end
    current_rating.save_prediction_info
    #byebug
    respond_to do |format|
      format.any { render json: {response: 'ok',rating: value}, content_type: 'application/json' }
    end
  end

  def show
    @song = Song.find_or_register(params[:id])
    @user = current_user
    @rating =@song.get_rating(@user)
    #byebug
    @recordings = @song.recordings.where(user: @user).order(created_at: :desc)
    #@recordings = Recording.all query: {bool: { must: [{ match: { user_id: @user.id}},{match: {song_id: @song.song_spotify_id}}]}},sort: [
    #  {date: {order: "desc", mode: "avg"}}]
  end

  def deal
    respond_to do |format|
      format.any { render json: {response: 'ok','License' => "EEG"}, content_type: 'application/json' }
    end
  end
  def discover
    @songs = Song.songs_to_discover(current_user).shuffle
  end
end
