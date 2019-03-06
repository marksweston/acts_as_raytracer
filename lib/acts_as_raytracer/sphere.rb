class Sphere
  def initialize(position:, radius:, colour:)
    @position = position
    @radius = radius
    @colour = colour
  end

  attr_reader :position, :radius, :colour

  def intersect(ray:)
    sphere_to_ray = ray.origin.to_v - position.to_v
    a = ray.direction.dot ray.direction
    b = 2 * ray.direction.dot(sphere_to_ray)
    c = sphere_to_ray.dot(sphere_to_ray) - radius**2
    discriminant = b**2 - 4 * a * c
    return nil if discriminant < 0

    t1 = (-b - Math.sqrt(discriminant)) / (2 * a)
    t2 = (-b + Math.sqrt(discriminant)) / (2 * a)
    return [{:distance => t1, :object => self}, {:distance => t2, :object => self}]
  end

  def normal_at(intersect:)
    return (position.to_v - intersect.to_v).normalize
  end

  def reflect(incoming:, normal:)
    return incoming - normal * 2 * incoming.dot(normal)
  end
end
