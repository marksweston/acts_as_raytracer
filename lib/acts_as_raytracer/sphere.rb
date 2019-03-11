class Sphere
  def initialize(position:, radius:, colour:)
    @position = position
    @radius = radius
    @colour = colour
  end

  attr_reader :position, :radius, :colour

  def intersect(ray:)
    sphere_to_ray = ray.origin.to_v - position.to_v
    binding.pry if ray.direction.is_a? RVec3
    a = Vector.dot(ray.direction, ray.direction)
    b = 2 * Vector.dot(ray.direction, sphere_to_ray)
    c = Vector.dot(sphere_to_ray, sphere_to_ray) - radius**2
    discriminant = b**2 - 4 * a * c
    return nil if discriminant < 0

    t1 = (-b - Math.sqrt(discriminant)) / (2 * a)
    t2 = (-b + Math.sqrt(discriminant)) / (2 * a)
    return [{:distance => t1, :object => self}, {:distance => t2, :object => self}]
  end

  def normal_at(intersect:)
    return (intersect.to_v - position.to_v).normalise!
  end

  def reflect(incoming:, normal:)
    return incoming - normal * 2 * Vector.dot(incoming, normal)
  end
end
