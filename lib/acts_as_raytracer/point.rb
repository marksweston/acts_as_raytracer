class Point
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
    freeze
  end

  attr_reader :x, :y, :z

  def to_v
    return Vector.new(x, y, z)
  end

  def move(vector:)
    return Point.new(self.x + vector.x, self.y + vector.y, self.z + vector.z)
  end

  def weighting
    return 1
  end

  def ==(other_point)
    return x == other_point.x && y == other_point.y && z == other_point.z
  end

  def transform(matrix:)
    return matrix * self
  end
end
