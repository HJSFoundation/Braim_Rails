class RecommendationsController < ApplicationController
  def index
    response =JSON.parse(`curl -H "Content-Type: application/json" \ -d '{ "user": #{current_user.id}, "num": 4 }' http://localhost:8000/queries.json`)["itemScores"]
    @recommendations = []
    response.each do |r|
      recommendation = Recommendation.new(r["item"].to_i,r["score"])
      @recommendations.push(recommendation)
    end
  end
end
