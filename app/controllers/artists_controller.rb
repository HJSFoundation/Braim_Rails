class ArtistsController < ApplicationController
  before_action :authenticate_user!
  def show
    @artist = RSpotify::Artist.find(params[:id])
    @songs = @artist.top_tracks("US")
    @artist_echonest = Echowrap.artist_profile(:id => "spotify:artist:#{@artist.id}",bucket: ['artist_location','genre','biographies','years_active'])
  end
end
