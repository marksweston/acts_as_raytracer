class Vector
  extend Forwardable

  def initialize(x, y, z)
    @vec = RVec3.new(x, y, z)
  end

  def self.dot(vector_1, vector_2)
    return RVec3.dot(vector_1.to_v, vector_2.to_v)
  end

  def_delegators :@vec, :x, :y, :z, :to_s

  def to_v
    return @vec
  end

  def normalise!
    @vec.normalize!
    return self
  end

  def -(other_vector)
    new_vec = @vec - other_vector.to_v
    return Vector.new(new_vec.x, new_vec.y, new_vec.z)
  end

  def *(scalar)
    return Vector.new((@vec * scalar).x, (@vec * scalar).y, (@vec * scalar).z)
  end

  def weighting
    return 0
  end

  def ==(other_vector)
    return @vec == other_vector.to_v
  end
end
