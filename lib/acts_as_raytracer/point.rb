class Point
  extend Forwardable

  def initialize(x, y, z)
    @vec = RVec3.new(x, y, z)
  end

  def_delegators :@vec, :x, :y, :z, :to_s

  def to_v
    return Vector.new(@vec.x, @vec.y, @vec.z)
  end

  def move(vector:)
    @vec.x = @vec.x + vector.x
    @vec.y = @vec.y + vector.y
    @vec.z = @vec.z + vector.z
    return self
  end

  def weighting
    return 1
  end

  def ==(other_point)
    return @vec.x == other_point.x && @vec.y == other_point.y && @vec.z == other_point.z
  end

  def transform(matrix:)
    return matrix * self
  end
end
