class Light
  def initialize(position:, intensity: Colour.white)
    @position = position
    @intensity = intensity
  end

  attr_reader :position, :intensity

  def illuminate(ray:, object:, point:, world: )
    normal = object.normal_at(intersect: point)
    # move the intersection a small amount "up" to fix "acne" effects due to floating point rounding errors
    over_point = point.move!(vector: normal * 0.00000001)
    effective_colour = object.colour

    light_vector = (self.position.to_v - over_point.to_v)
    distance_to_light = light_vector.magnitude
    in_shadow = point_in_shadow?(over_point, light_vector, distance_to_light, world)

    ambient = effective_colour * object.material.ambient
    light_dot_normal = light_vector.normalise.dot_product(normal)

    if light_dot_normal < 0 || in_shadow
      diffuse = Colour.black
      specular = Colour.black
    else
      diffuse = effective_colour * object.material.diffuse_reflection * light_dot_normal
      reflection = object.reflect(incoming_ray: ray.vector, intersection: point)
      # reversing the ray vector otherwise the angle to the reflection is always > 90'
      reflect_dot_ray = reflection.dot_product(-ray.vector)
      if reflect_dot_ray <= 0
        specular = Colour.black
      else
        specular = intensity * object.material.specular_reflection * (reflect_dot_ray ** object.material.shininess)
      end
    end
    return ambient + diffuse + specular
  end

  private def point_in_shadow?(point, light_vector, distance_to_light, world)
    shadow_ray = Ray.new(origin: point, vector: light_vector.normalise)
    shadow_intersections = shadow_ray.trace(objects: world.objects)
    return shadow_intersections.select{ |intersection| intersection.t < distance_to_light }.count > 0
  end
end
