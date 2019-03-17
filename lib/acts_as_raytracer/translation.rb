class Transform
  class Translation < Transform
    def self.new_from_matrix(matrix)
      translation = allocate
      translation.initialize_from_matrix(matrix)
      return translation
    end

    def initialize(x: 0, y: 0, z: 0)
      @transform_matrix = RMtx4.new(
         1, 0, 0, x,
         0, 1, 0, y,
         0, 0, 1, z,
         0, 0, 0, 1
      )
    end
  end
end
