class Vector
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
    freeze
  end

  attr_reader :x, :y, :z

  def dot_product(other_vector)
    return x * other_vector.x + y * other_vector.y + z * other_vector.z
  end

  def normalise
    return Vector.new(self.x / magnitude, self.y / magnitude, self.z / magnitude)
  end

  def -(other_vector)
    return Vector.new(x - other_vector.x, y - other_vector.y, z - other_vector.z)
  end

  def *(scalar)
    return Vector.new(x * scalar, y * scalar, z * scalar)
  end

  def -@
    return Vector.new(-x, -y, -z)
  end

  def weighting
    return 0
  end

  def ==(other_vector)
    return x == other_vector.x && y == other_vector.y && z == other_vector.z
  end

  def transform(matrix:)
    return matrix * self
  end

  def magnitude
    return Math.sqrt(x ** 2 + y ** 2 + z ** 2)
  end
end
