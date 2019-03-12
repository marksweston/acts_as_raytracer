module Transform
  class Scaling
    def self.new_from_matrix(matrix)
      scaler = allocate
      scaler.initialize_from_matrix(matrix)
      return scaler
    end

    def initialize_from_matrix(matrix)
      @transform_matrix = matrix
    end

    def initialize(x: 0, y: 0, z: 0)
      @transform_matrix = RMtx4.new(
          x, 0, 0, 0,
          0, y, 0, 0,
          0, 0, z, 0,
          0, 0, 0, 1
      )
    end

    attr_accessor :transform_matrix

    def *(point_or_vector)
      transformable = RVec4.new(
          point_or_vector.x,
          point_or_vector.y,
          point_or_vector.z,
          point_or_vector.weighting
      )
      result = transformable.transform(transform_matrix)
      return point_or_vector.class.new(
          result.x,
          result.y,
          result.z
      )
    end

    def inverse
      return @inverse ||= Transform::Translation.new_from_matrix(transform_matrix.getInverse)
    end
  end
end
