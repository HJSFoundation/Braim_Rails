class ColabFiltering
  attr_accessor :user

  def initialize(user)  
    @user = user  
  end 

  def prediction(song, neighborhood_sum, neighborhood)
    score = 0.0
    if @user.songs.include? song
      puts "Already known song"
    end
    #rating = Rating.search_value_by(@user,song)
    difference = numerator(song,neighborhood) / neighborhood_sum
    if difference > 0.0
      score =  @user.rating_average + difference
    else
      score = nil
    end
    
    score
  end 

  #private

  def numerator(song,neighborhood)
    sum = 0.0
    neighborhood.each do |neighbor|
      if neighbor.score >= 0.4
        neighbor_rating = Rating.search_value_by(neighbor.user,song)
        if neighbor_rating
          rating_diff = neighbor_rating.value - neighbor.user.rating_average
          sum = sum + (rating_diff * neighbor.score)
        end
      end
    end
    sum
  end

  # def denumerator(song)
  #   sum = 0.0
  #   user.neighborhood.each do |neighbor|
  #     sum = sum + neighbor.score.abs
  #   end
  #   sum
  # end
end