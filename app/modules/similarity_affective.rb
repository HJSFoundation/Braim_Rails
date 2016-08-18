class SimilarityAffective 
  attr_accessor :user_first , :user_second
  attr_reader :common_items,:ratings_first, :ratings_second , :pearson_average

  def initialize(user1,user2,state)
    @user_first = user1
    @user_second = user2
    @state = state
    @common_items = @user_first.recorded_songs & @user_second.recorded_songs
    @pearson_average = calculate_pearson_average
  end

  private
  def calculate_pearson_average
    if @common_items.any?
      correlations = []
      @common_items.each do |song| 
        recording_data_first = get_recording_data(Recording.search_by(song,@user_first))
        recording_data_second = get_recording_data(Recording.search_by(song,@user_second))
        #byebug
        correlations << Pearson.gsl_pearson(recording_data_first,recording_data_second) if (recording_data_first.any? && recording_data_second.any?)
      end
      correlations
      similarity = (correlations.inject(0){|cor,x| cor+x})/correlations.count
    end
  end

  def get_recording_data(recording)
    (recording.entries.collect{|entry| entry[@state]}).take(30)
  end

end
