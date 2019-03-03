class Position
  def Position.[](x, y, z)
    new(x: x, y: y, z: z)
  end

  def initialize(x:, y:, z:)
    @x = x
    @y = y
    @z = z
  end

  attr_reader :x, :y, :z
end
