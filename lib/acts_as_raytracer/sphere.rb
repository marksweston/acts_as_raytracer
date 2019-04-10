class Sphere
  def initialize(colour: Colour.new(red: 0, green: 0, blue: 0))
    @colour = colour
    @transforms = []
  end

  private def object_space_origin
    return Point.new(0, 0, 0)
  end

  private def unit_radius_squared
    return 1
  end

  attr_reader :colour, :transforms

  def combined_transform
    return @combined_transform ||= transforms.reverse.reduce(Transform::Identity.new) do |combined, transform|
      combined * transform
    end
  end

  def scale(x:, y:, z:)
    self.transforms << Transform::Scaling.new(x: x, y: y, z: z)
    return self
  end

  def translate(x:, y:, z:)
    self.transforms << Transform::Translation.new(x: x, y: y, z: z)
    return self
  end

  def rotate(axis:, angle: )
    self.transforms << Transform::Rotation.new(axis: axis, angle: angle)
    return self
  end

  def intersect(ray:)
    ray_in_object_space = ray.transform(matrix: combined_transform.inverse)
    sphere_to_ray = ray_in_object_space.origin.to_v - object_space_origin.to_v
    a = Vector.dot_product(ray_in_object_space.direction, ray_in_object_space.direction)
    b = 2 * Vector.dot_product(ray_in_object_space.direction, sphere_to_ray)
    c = Vector.dot_product(sphere_to_ray, sphere_to_ray) - unit_radius_squared
    discriminant = b**2 - 4 * a * c
    return nil if discriminant < 0

    t1 = (-b - Math.sqrt(discriminant)) / (2 * a)
    t2 = (-b + Math.sqrt(discriminant)) / (2 * a)
    return [{:distance => t1, :object => self}, {:distance => t2, :object => self}]
  end

  def normal_at(intersect:)
    intersect_in_object_space = combined_transform.inverse * intersect
    object_space_normal = intersect_in_object_space.to_v
    world_space_normal = combined_transform.inverse.transpose * object_space_normal
    return world_space_normal.normalise!
  end

  def reflect(incoming:, normal:)
    return incoming - normal * 2 * Vector.dot_product(incoming, normal)
  end
end
