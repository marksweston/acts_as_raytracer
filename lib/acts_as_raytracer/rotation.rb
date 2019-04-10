class Transform
  class Rotation < Transform
    include Math
    def self.new_from_matrix(matrix)
      rotation = allocate
      rotation.initialize_from_matrix(matrix)
      return rotation
    end

    def initialize(axis:, angle:)
      @transform_matrix = transform_matrix_for axis, angle
    end
  end

  private def transform_matrix_for(axis, angle)
    return {
        :x => RMtx4.new(
            1, 0,       0,           0,
            0, cos(angle), -sin(angle), 0,
            0, sin(angle), cos(angle),  0,
            0, 0,          0,           1
        ),
        :y => RMtx4.new(
            cos(angle),  0, sin(angle), 0,
            0,           1, 0,          0,
            -sin(angle), 0, cos(angle), 0,
            0,           0, 0,          1
        ),
        :z => RMtx4.new(
            cos(angle), -sin(angle), 0, 0,
            sin(angle), cos(angle),  0, 0,
            0,          0,           1, 0,
            0,          0,           0, 1
        )
    }[axis]
  end
end
