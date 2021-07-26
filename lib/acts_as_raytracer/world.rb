class World
  def initialize(objects:, light:)
    @objects = objects
    @light = light
  end

  attr_reader :objects, :light

  def trace(ray:)
    intersections = ray.trace(objects: objects)
    return Colour.black if intersections.empty?

    intersection_point = ray.at(t: intersections.first.t)

    return illuminate(
      ray: ray,
      intersection_point: intersection_point,
      object: intersections.first.object,
    )
  end

  def illuminate(ray:, object:, intersection_point: )
    normal = object.normal_at(intersect: intersection_point)
    # move the intersection a small amount "up" to fix "acne" effects due to floating point rounding errors
    over_point = intersection_point.move!(vector: normal * 0.00000001)
    effective_colour = object.colour.product(self.light.intensity)

    light_vector = (light.position.to_v - over_point.to_v).normalise
    in_shadow = point_in_shadow?(over_point, light_vector)

    ambient = effective_colour * object.material.ambient
    light_dot_normal = light_vector.dot_product(normal)

    if light_dot_normal < 0 || in_shadow
      diffuse = Colour.black
      specular = Colour.black
    else
      diffuse = effective_colour * object.material.diffuse_reflection * light_dot_normal
      specular = phong_specular(intersection_point, object, ray, light_vector)
    end
    return ambient + diffuse + specular
  end

  private def point_in_shadow?(point, light_vector)
    shadow_ray = Ray.new(origin: point, vector: light_vector.normalise)
    shadow_intersections = shadow_ray.trace(objects: self.objects)
    return shadow_intersections.select{ |intersection| intersection.t < light_vector.magnitude }.count > 0
  end

  private def phong_specular(intersection_point, object, ray, light_vector)
    reflection = object.reflect(incoming_ray: -light_vector, intersection: intersection_point)
    # reversing the ray direction otherwise the angle to the reflection is always > 90'
    reflect_dot_ray = reflection.dot_product(-ray.vector)
    if reflect_dot_ray <= 0
      return Colour.black
    else
      return light.intensity * object.material.specular_reflection * (reflect_dot_ray ** object.material.shininess)
    end
  end
end
