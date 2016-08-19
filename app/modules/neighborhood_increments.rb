class NeighborhoodIncrements
  attr_reader :neighbors , :user , :neighbors_sum , :state
  def initialize(user,state)  
    @user = user  
    @state = state
    @neighbors = get_neighbors
    @neighbors_sum  = calculate_sum
  end  

  private

  def get_neighbors
    all_users = User.where.not(id: @user.id)
    result = []
    all_users.each do |neighbor|
      correlation = SimilarityIncrements.new(@user,neighbor,@state).sim_value
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