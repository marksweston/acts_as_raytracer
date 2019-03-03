class World
  def initialize(objects:)
    @objects = objects
  end

  attr_reader :objects

  def trace(ray:)
    return [0, 0, 255]
  end
end
