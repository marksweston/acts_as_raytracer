class Transform
  class Identity < Transform
    def initialize
      @transform_matrix = RMtx4.new(
         1, 0, 0, 0,
         0, 1, 0, 0,
         0, 0, 1, 0,
         0, 0, 0, 1
      )
    end

    attr_accessor :transform_matrix

    def *(point_or_vector)
      return point_or_vector
    end

    def inverse
      return self
    end

    def transpose
      return self
    end
  end
end
