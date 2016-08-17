class Mrse
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
    
    total = 0
    ratings.each do |rating|
      user = rating.user
      song = rating.song
      colab_filtering = ColabFiltering.new(user)
      score = colab_filtering.traditional_prediction(song)

      # #byebug
      if score
        total = total + ((score - rating.value )**2)
        #byebug
      end
    end

    mrse = Math.sqrt(total / ratings.count)
  
  end
end