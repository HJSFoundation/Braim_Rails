class RecommendationsController < ApplicationController
  def index
    response =JSON.parse(`curl -H "Content-Type: application/json" \ -d '{ "user": #{current_user.id}, "num": 15 }' http://localhost:8000/queries.json`)["itemScores"]
    @recommendations = []
    response.each do |r|
      recommendation = Recommendation.new(r["item"].to_i,r["score"])
      @recommendations.push(recommendation)
    end
    user_recordings = current_user.recordings
    user_songs = user_recordings.collect{|r| r.song}
    user_songs.each do |user_song| 
      @recommendations.delete_if {|rec| rec.item == user_song.id}
    end
  end

  def test
    offset = rand(Song.count)
    song_id = params[:id] || offset
    @song = Song.find(song_id)
    @rating = @song.get_rating(current_user)
  end
end
