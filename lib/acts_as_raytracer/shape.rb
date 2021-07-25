class Shape
  def initialize(colour: Colour.new(red: 0, green: 0, blue: 0), material: nil)
    @colour = colour
    @transforms = []
    @material = material
  end

  attr_reader :colour, :transforms

  def self.default_material
    return Material.new(
      ambient: 0.15,
      diffuse_reflection: 0.9,
      specular_reflection: 0.9,
      shininess: 20
    )
  end

  protected def object_space_origin
    return Point.new(0, 0, 0)
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

  def skew(x_y: 0, x_z: 0, y_x: 0, y_z: 0, z_x: 0, z_y: 0)
    self.transforms << Transform::Skew.new(x_y: x_y, x_z: x_z, y_x: y_x, y_z: y_z, z_x: z_x, z_y: z_y)
    return self
  end

  def combined_transform
    return @combined_transform ||= transforms.reverse.reduce(Transform::Identity.new) do |combined, transform|
      combined * transform
    end
  end

  def object_space(ray_point_or_vector)
    return ray_point_or_vector.transform(matrix: combined_transform.inverse)
  end

  def world_space(ray_point_or_vector)
    return ray_point_or_vector.transform(matrix: combined_transform.inverse.transpose)
  end

  def reflect(incoming_ray:, intersection:)
    normal = normal_at(intersect: intersection)
    return incoming_ray - normal * 2 * incoming_ray.dot_product(normal)
  end

  def material
    return @material ||= self.class.default_material
  end
end
