class ColabFiltering
  attr_accessor :user
  attr_reader :neighborhood

  def initialize(user)  
      @user = user  
      @neighborhood = user.neighborhood
  end 

  def prediction(song)
    score = 0.0
    #puts "The user already known song" if @user.songs.include? song
    #rating = Rating.search_value_by(@user,song)
    difference = numerator(song) / @neighborhood.neighbors_sum
    if difference > 0.0
      score =  @user.rating_average + difference
    else
      score = nil
    end
    score
  end 

  private

  def numerator(song)
    sum = 0.0
    @neighborhood.neighbors.each do |neighbor|
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
end