class SimilarityIncrements
  attr_accessor :user_first , :user_second
  attr_reader :common_items,:ratings_first, :ratings_second , :sim_value , :state

  def initialize(user1,user2,state)
    @user_first = user1
    @user_second = user2
    @state = state
    @common_items = @user_first.songs & @user_second.songs
    @ratings_first = get_increments(@user_first)
    @ratings_second = get_increments(@user_second)
    @sim_value = pearson
  end

  private

  def pearson
    if @common_items.any?
      res = Pearson.gsl_pearson(@ratings_first,@ratings_second)
      #res = res * 0.4 if @common_items.count <= 1
      res = nil if res.nan?
      res
    end
  end

  def get_increments(user)
    r = []
    @common_items.each do |song|
      increments_counter = 0
      recording = Recording.search_by(song,user)
      increments_counter = recording.increments_counter(@state) if recording
      r << increments_counter
    end
    r
  end

 

end