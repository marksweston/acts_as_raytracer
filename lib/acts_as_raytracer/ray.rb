class Ray
  def initialize(origin:, direction:, position_on_film: nil)
    @origin = origin
    @direction = direction
    @position_on_film = position_on_film
  end

  attr_reader :origin, :direction, :position_on_film
  attr_accessor :colour

  def at(t:)
    change_vector = direction * t
    return Point.new(
      origin.x + change_vector.x,
      origin.y + change_vector.y,
      origin.z + change_vector.z
    )
  end

  def transform(matrix:)
    return Ray.new(
      origin: matrix * self.origin,
      direction: matrix * self.direction,
      position_on_film: self.position_on_film
    )
  end

  def to_s
    return "origin: #{origin} - direction: #{direction}"
  end

  def trace(objects:)
    intersections = objects.map do |object|
      object.intersect(ray: self)
    end.flatten.compact
    # making sure that floating point errors don't give us an intersection point that's *below* the surface of the object
    return intersections.sort.select{|intersection| intersection.t > 10**-epsilon}
  end
end
