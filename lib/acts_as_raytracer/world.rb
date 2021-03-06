class World
  def initialize(objects:, light:)
    @objects = objects
    @light = light
  end

  attr_reader :objects, :light
  attr_accessor :intersections

  def trace(ray:)
    intersections = ray.trace(objects: objects)
    return Colour.black if intersections.empty?

    intersection_point = ray.at(t: intersections.first.t)

    return light.illuminate(
        point: intersection_point,
        object: intersections.first.object,
        world: self
    )
  end
end
