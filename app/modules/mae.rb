require "csv"
class Mae
  # attr_accessor :user , :score
  # def initialize(user, score)  
  #   @user = user  
  #   @score = score  
  # end  

  def self.calculate
    values = []
    sections = Rating.all.in_groups(10,false)
    sections.each_with_index do |section,i|
      values << self.calculate_section(section)
      puts "MAE #{(i+1)*10}% complete"
    end 
    values
  end

  def self.calculate_section(ratings)
    #total_neighbors = user.neighborhood
    #sum = user.neighbor_sum(total_neighbors)

    #listened_songs = users.collect{|u| u.songs}

    total = 0
    counter = 0
    ratings.each do |rating|
      user = rating.user
      song = rating.song
      colab_filtering = ColabFiltering.new(user)
      score = colab_filtering.prediction(song)
      
      # #byebug
      if score
        total = total + (score - rating.value )
        counter += 1
        #byebug
      end
    end

    mae = total.abs / counter
  
  end
end
