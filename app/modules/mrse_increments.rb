class MrseIncrements
  # attr_accessor :user , :score
  # def initialize(user, score)  
  #   @user = user  
  #   @score = score  
  # end  

  def self.calculate(state)
    values = []
    sections = Rating.all.in_groups(10)
    sections.each_with_index do |section,i|
      values << self.calculate_section(section,state)
      puts "MRSE increments #{state} #{(i+1)*10}% complete"
    end 
    values
  end

  def self.calculate_section(ratings,state)
    
    total = 0
    counter = 0
    ratings.each do |rating|
      user = rating.user
      song = rating.song
      colab_filtering = ColabFilteringIncrements.new(user,state)
      score = colab_filtering.prediction(song)

      # #byebug
      if score
        total = total + ((score - rating.value )**2)
        counter += 1
        #byebug
      end
    end
    counter = 1 if counter == 0
    mrse = Math.sqrt(total / counter)
  
  end
end