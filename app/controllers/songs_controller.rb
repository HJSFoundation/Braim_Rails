class SongsController < ApplicationController
  def search
    if params[:query]
      @songs =  Echowrap.song_search(title: params[:query]) 
    end
    respond_to do |format|
      format.html 
      format.js { render :template => '/songs/search'}
    end
  end

  def show
  end
end
