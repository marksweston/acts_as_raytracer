class Point
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  attr_accessor :x, :y, :z

  def to_v
    return Vector.new(x, y, z)
  end

  def move!(vector:)
    self.x = self.x + vector.x
    self.y = self.y + vector.y
    self.z = self.z + vector.z
    return self
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
