class Transform
  class Scaling < Transform
    def self.new_from_matrix(matrix)
      scaler = allocate
      scaler.initialize_from_matrix(matrix)
      return scaler
    end

    def initialize(x: 0, y: 0, z: 0)
      @transform_matrix = RMtx4.new(
          x, 0, 0, 0,
          0, y, 0, 0,
          0, 0, z, 0,
          0, 0, 0, 1
      )
    end
  end
end
