class Similarity 
  attr_accessor :user_first , :user_second
  attr_reader :common_items,:ratings_first, :ratings_second , :sim_value

  def initialize(user1,user2)
    @user_first = user1
    @user_second = user2
    @common_items = @user_first.songs & @user_second.songs
    @ratings_first = get_ratings(@user_first)
    @ratings_second = get_ratings(@user_second)
    @sim_value = pearson
  end

  private

  def pearson
    if @common_items.any?
      res = Pearson.gsl_pearson(@ratings_first,@ratings_second)
      res = res * 0.4 if @common_items.count <= 1
      res = nil if res.nan?
      res
    end
  end

  def get_ratings(user)
    r = []
    @common_items.each do |song|
      rating = Rating.search_value_by(user,song)
      if rating
        r << rating.value
      end
    end
    r
  end

  # def total 
  #   total =  numerator / denumerator
  #   if common_songs.count <= 1
  #     total = total * 0.4
  #   end
  #   total
  # end

  #private

  # def numerator
  #   sum = 0.0
  #   common_songs.each do |song|
  #     user_1_diff = Rating.search_value_by(@user_first,song).value - @user_first.rating_average
  #     user_2_diff = Rating.search_value_by(@user_second,song).value - @user_second.rating_average
  #     sum = sum + (user_1_diff * user_2_diff)
  #   end 
  #   sum
  # end

  # def denumerator
  #   sum_first = 0.0
  #   sum_second = 0.0
  #   total = 0.0 
  #   common_songs.each do |song|
  #     user_1_diff = Rating.search_value_by(@user_first,song).value - @user_first.rating_average
  #     user_2_diff = Rating.search_value_by(@user_second,song).value - @user_second.rating_average
  #     sum_first = sum_first + (user_1_diff**2)
  #     sum_second = sum_second + (user_2_diff**2)
  #   end 
  #   total = Math.sqrt(sum_first) * Math.sqrt(sum_second) 
  #   if total == 0.0
  #     total = 1 
  #   end
  #   total
  # end

end

