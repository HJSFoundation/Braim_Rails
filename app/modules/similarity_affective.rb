class SimilarityAffective 
  attr_accessor :user_first , :user_second
  attr_reader :common_items,:ratings_first, :ratings_second , :sim_value , :mode ,:state

  def initialize(user1,user2,state,mode)
    @user_first = user1
    @user_second = user2
    @state = state
    @mode = mode
    @common_items = @user_first.recorded_songs & @user_second.recorded_songs
    @sim_value = calculate_pearson_average
  end

  private
  def calculate_pearson_average
    if @common_items.any?
      similarity = nil
      if @mode == "average"
        correlations = []
        @common_items.each do |song| 
          recording_data_first = get_recording_data(Recording.search_by(song,@user_first))
          recording_data_second = get_recording_data(Recording.search_by(song,@user_second))
          #byebug
          correlations << Pearson.gsl_pearson(recording_data_first,recording_data_second) if (recording_data_first.any? && recording_data_second.any?)
        end
        
        similarity = (correlations.inject(0){|cor,x| cor+x})/correlations.count if correlations.any?
      elsif @mode == "sum"
        correlation = []
        recording_data_first = []
        recording_data_second  = []
        @common_items.each do |song| 
          recording_data_first = recording_data_first.concat(get_recording_data(Recording.search_by(song,@user_first)))
          recording_data_second = recording_data_second.concat(get_recording_data(Recording.search_by(song,@user_second)))  
          #byebug
        end
        #byebug
        similarity = Pearson.gsl_pearson(recording_data_first,recording_data_second) if (recording_data_first.any? && recording_data_second.any?)
        #byebug
      end
      similarity = nil if similarity.nan?
      similarity
    end
  end

  def get_recording_data(recording)

    (recording.entries.collect{|entry| entry[@state]}).take(30)
  end

end
