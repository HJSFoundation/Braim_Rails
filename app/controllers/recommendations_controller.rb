class RecommendationsController < ApplicationController
  def index
    # response =JSON.parse(`curl -H "Content-Type: application/json" \ -d '{ "user": #{current_user.id}, "num": 15 }' http://localhost:8000/queries.json`)["itemScores"]
    # @recommendations = []
    # response.each do |r|
    #   item_id = r["item"].to_i
    #   if Song.exists? item_id 
    #     recommendation = Recommendation.new(item_id,r["score"])
    #     @recommendations.push(recommendation)
    #   end
    # end
    # user_recordings = current_user.recordings
    # user_songs = user_recordings.collect{|r| r.song}
    # user_songs.each do |user_song| 
    #   @recommendations.delete_if {|rec| rec.item == user_song.id}
    # end
  end

  def test
    if params[:id]
      song_id = params[:id] 
      @song = Song.find(song_id)
    else
      offset = rand(Song.where.not(preview_url: nil).count)
      @song = Song.where.not(preview_url: nil).offset(offset).first
    end
    @rating = @song.get_rating(current_user)
    respond_to do |format| 
      format.html
      format.js
    end
  end
end
