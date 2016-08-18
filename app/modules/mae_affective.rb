class MaeAffective
  # attr_accessor :user , :score
  # def initialize(user, score)  
  #   @user = user  
  #   @score = score  
  # end  

  def self.calculate(state,mode)
    values = []
    sections = Recording.all_min.in_groups(10,false)
    sections.each do |section|
      values << self.calculate_section(section,state,mode)
    end 
    values
  end

  def self.calculate_section(recordings,state,mode)
    #total_neighbors = user.neighborhood
    #sum = user.neighbor_sum(total_neighbors)

    #listened_songs = users.collect{|u| u.songs}

    total = 0
    counter = 0
    recordings.each do |recording|
      user = recording.user
      song = recording.song
      colab_filtering = ColabFilteringAffective.new(user,state,mode)
      score = colab_filtering.prediction(song)
      user_rating = Rating.search_value_by(user,song)
      user_rating ? rating = user_rating.value : rating = user.rating_average
      #byebug
      if score
        total = total + (score - rating)
        counter += 1
        #byebug
      end
    end

    mae = total.abs / counter
  
  end
end