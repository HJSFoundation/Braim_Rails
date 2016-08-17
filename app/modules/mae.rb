class Mae
  # attr_accessor :user , :score
  # def initialize(user, score)  
  #   @user = user  
  #   @score = score  
  # end  

  def self.calculate
    values = []
    sections = Rating.all.each_slice(10)
    sections.each do |section|
      values << self.calculate_section(section)
    end 
    values
  end

  def self.calculate_section(ratings)
    #total_neighbors = user.neighborhood
    #sum = user.neighbor_sum(total_neighbors)

    #listened_songs = users.collect{|u| u.songs}

    total = 0
    ratings.each do |rating|
      user = rating.user
      song = rating.song
      colab_filtering = ColabFiltering.new(user)
      total_neighbors = user.neighborhood
      sum = user.neighbor_sum(total_neighbors)
      score = colab_filtering.prediction(song,sum,total_neighbors)

      
      # #byebug
      if score
        total = total + (score - rating.value )
        #byebug
      end
    end

    mae = total.abs / ratings.count
  
  end
end
