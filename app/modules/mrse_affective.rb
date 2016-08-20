require "csv"
class MrseAffective
  # attr_accessor :user , :score
  # def initialize(user, score)  
  #   @user = user  
  #   @score = score  
  # end  

  def self.calculate(state,mode)
    values = []
    all_prediction_errors = []
    all_ratings = Rating.all

    all_ratings.each_with_index do |rating,i|
      user = rating.user
      song = rating.song
      colab_filtering = ColabFilteringAffective.new(user,state,mode)
      score = colab_filtering.prediction(song)
      prediction_error = PredictionError.new(rating, score)
      all_prediction_errors << prediction_error if score
      print "MRSE affective prediction #{state} #{mode} #{(i*100)/all_ratings.count}% complete"+ "\r"
    end 

    all_prediction_errors.in_groups(10,false).each_with_index do |section,i|
      values << self.calculate_section(section)
    end
    values
  end

  def self.calculate_section(prediction_errors)
    total = 0
    counter = 0
    prediction_errors.each do |prediction_error|
      total = total + ((prediction_error.score - prediction_error.rating.value )**2)
      counter += 1
    end
    mrse = Math.sqrt(total / counter)
  end
end
