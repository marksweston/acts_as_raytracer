class Position
  def Position.[](x, y, z)
    new(x: x, y: y, z: z)
  end

  def initialize(x: 0, y: 0, z: 0)
    @x = x
    @y = y
    @z = z
  end

  attr_reader :x, :y, :z

  def to_v
    return Vector[x, y, z]
  end

  def move(vector:)
    return Position[
      x + vector[0],
      y + vector[1],
      z + vector[2],
    ]
  end

  def to_s
    return "x: #{x}, y: #{y}, z: #{z}"
  end
end
