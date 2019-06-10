class Sphere < Shape

  private def unit_radius_squared
    return 1
  end

  def intersect(ray:)
    sphere_to_ray = object_space(ray).origin.to_v - object_space_origin.to_v
    a = Vector.dot_product(object_space(ray).direction, object_space(ray).direction)
    b = 2 * Vector.dot_product(object_space(ray).direction, sphere_to_ray)
    c = Vector.dot_product(sphere_to_ray, sphere_to_ray) - unit_radius_squared
    discriminant = b**2 - 4 * a * c
    return nil if discriminant < 0

    t1 = (-b - Math.sqrt(discriminant)) / (2 * a)
    t2 = (-b + Math.sqrt(discriminant)) / (2 * a)
    return [{:t => t1, :object => self}, {:t => t2, :object => self}]
  end

  def normal_at(intersect:)
    return world_space(object_space(intersect).to_v).normalise!
  end
end
