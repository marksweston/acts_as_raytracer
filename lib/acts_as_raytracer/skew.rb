class Transform
  class Skew < Transform
    def self.new_from_matrix(matrix)
      skew = allocate
      skew.initialize_from_matrix(matrix)
      return skew
    end

    def initialize(x_y: 0, x_z: 0, y_x: 0, y_z: 0, z_x: 0, z_y: 0)
      @transform_matrix = RMtx4.new(
          1,  x_y,  x_z, 0,
          y_x, 1,   y_z, 0,
          z_x, z_y, 1,   0,
          0,   0,   0,   1
      )
    end
  end
end
