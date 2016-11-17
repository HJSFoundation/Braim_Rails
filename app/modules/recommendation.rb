class Recommendation 
  attr_accessor :item , :score
  def initialize(item_value,score_value)
    @item = item_value
    @score = score_value
  end
  def song
    Song.find(self.item) 
  end
end