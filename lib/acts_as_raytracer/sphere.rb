class Sphere < Shape

  private def unit_radius_squared
    return 1
  end

  def intersect(ray:)
    sphere_to_ray = object_space(ray).origin.to_v - object_space_origin.to_v
    a = object_space(ray).vector.dot_product(object_space(ray).vector)
    b = 2 * object_space(ray).vector.dot_product(sphere_to_ray)
    c = sphere_to_ray.dot_product(sphere_to_ray) - unit_radius_squared
    discriminant = b**2 - 4 * a * c
    return [] if discriminant < 0

    t1 = (-b - Math.sqrt(discriminant)) / (2 * a)
    t2 = (-b + Math.sqrt(discriminant)) / (2 * a)
    return [
        Intersection.new(t: t1, object: self),
        Intersection.new(t: t2, object: self)
    ]
  end

  def normal_at(intersect:)
    return world_space(object_space(intersect).to_v).normalise
  end
end
