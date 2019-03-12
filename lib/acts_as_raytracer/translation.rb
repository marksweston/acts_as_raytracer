module Transform
  class Translation
    def self.new_from_matrix(matrix)
      translation = allocate
      translation.initialize_from_matrix(matrix)
      return translation
    end

    def initialize_from_matrix(matrix)
      @transform_matrix = matrix
    end

    def initialize(x: 0, y: 0, z: 0)
      @transform_matrix = RMtx4.new(
         1, 0, 0, x,
         0, 1, 0, y,
         0, 0, 1, z,
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
