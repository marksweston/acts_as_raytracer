class Transform
  attr_accessor :transform_matrix

  def initialize_from_matrix(matrix)
    @transform_matrix = matrix
  end

  def *(multiplicand)
    case multiplicand
    when Point, Vector
      return transform_point_or_vector(multiplicand)
    when Transform
      return self.class.new_from_matrix(self.transform_matrix * multiplicand.transform_matrix)
    end
  end

  def transpose
    return @transpose ||= self.class.new_from_matrix(self.transform_matrix.getTransposed)
  end

  def inverse
    return @inverse ||= self.class.new_from_matrix(transform_matrix.getInverse)
  end

  private def transform_point_or_vector(point_or_vector)
    transformable = RVec4.new(
        point_or_vector.x,
        point_or_vector.y,
        point_or_vector.z,
        point_or_vector.weighting
    )
    result = transformable.transform(transform_matrix)
    return point_or_vector.class.new(
        result.x.round(12),
        result.y.round(12),
        result.z.round(12)
    )
  end
end
