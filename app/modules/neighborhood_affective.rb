class NeighborhoodAffective
  attr_reader :neighbors , :user , :neighbors_sum , :state , :mode
  def initialize(user,state, mode)  
    @user = user  
    @state = state
    @mode = mode
    @neighbors = get_neighbors
    @neighbors_sum  = calculate_sum
  end  

  private

  def get_neighbors
    all_users = User.where.not(id: @user.id)
    result = []
    all_users.each do |neighbor|
      correlation = SimilarityAffective.new(@user,neighbor, @state , @mode).sim_value
      result << Neighbor.new(neighbor, correlation) if correlation
    end
    result.sort_by(&:score).reverse
  end

  def calculate_sum
    sum = 0.0
    @neighbors.each do |neighbor|
      sum = sum + neighbor.score.abs
    end
    sum
  end
end
