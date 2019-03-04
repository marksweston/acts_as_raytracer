class World
  def initialize(objects:)
    @objects = objects
  end

  attr_reader :objects
  attr_accessor :intersections

  def trace(ray:)
    self.intersections = objects.map do |object|
      object.intersect(ray: ray)
    end.flatten.compact
    intersections.sort!{ |first_hit, second_hit| first_hit[:distance] <=> second_hit[:distance] }
    if intersections.empty?
      return [0, 0, 255]
    else
      return intersections.first[:object].colour
    end
  end
end
