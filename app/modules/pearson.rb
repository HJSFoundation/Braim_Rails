require 'gsl'

class Pearson
  def self.gsl_pearson(x,y)
    GSL::Stats::correlation(
      GSL::Vector.alloc(x),GSL::Vector.alloc(y)
    )
  end
end