class PredictionError
  attr_accessor :rating , :score
  def initialize(rating, score)  
    @rating = rating  
    @score = score  
  end  
end
