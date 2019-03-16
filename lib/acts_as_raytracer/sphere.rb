class Sphere
  def initialize(colour: Colour.new(red: 0, green: 0, blue: 0))
    @position = Point.new(0, 0, 0)
    @radius = 1
    @colour = colour
    @transforms = [Transform::Identity.new]
  end

  attr_reader :position, :radius, :colour
  attr_accessor :transforms

  def scale(x:, y:, z:)
    self.transforms << Transform::Scaling.new(x: x, y: y, z: z)
    return self
  end

  def translate(x:, y:, z:)
    self.transforms << Transform::Translation.new(x: x, y: y, z: z)
    return self
  end

  def intersect(ray:)
    object_space_ray = self.transforms.reduce(ray) do |new_ray, transform|
      new_ray.transform(matrix: transform.inverse)
    end
    sphere_to_ray = object_space_ray.origin.to_v - position.to_v
    a = Vector.dot_product(object_space_ray.direction, object_space_ray.direction)
    b = 2 * Vector.dot_product(object_space_ray.direction, sphere_to_ray)
    c = Vector.dot_product(sphere_to_ray, sphere_to_ray) - radius**2
    discriminant = b**2 - 4 * a * c
    return nil if discriminant < 0

    t1 = (-b - Math.sqrt(discriminant)) / (2 * a)
    t2 = (-b + Math.sqrt(discriminant)) / (2 * a)
    return [{:distance => t1, :object => self}, {:distance => t2, :object => self}]
  end

  def normal_at(intersect:)
    object_space_intersect = self.transforms.reduce(intersect) do |new_intersect, transform|
      transform.inverse * new_intersect
    end
    object_space_normal = object_space_intersect.to_v
    world_space_normal = self.transforms.reduce(object_space_normal) do |normal, transform|
      transform.inverse.transpose * normal
    end
    return world_space_normal.normalise!
  end

  def reflect(incoming:, normal:)
    return incoming - normal * 2 * Vector.dot_product(incoming, normal)
  end
end
