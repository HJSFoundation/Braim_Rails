class SongsController < ApplicationController
  def search
    if params[:query]
      @songs =  Echowrap.song_search(title: params[:query], results:20, bucket: 'song_type', sort: "artist_hotttnesss-desc")
      @artists = Echowrap.artist_search(name: 'juanes', results:1, bucket: ['artist_location','images','genre'])
    end
    respond_to do |format|
      format.html 
      format.js { render :template => '/songs/search'}
    end
  end

  def show
  end
end
