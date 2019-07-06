class Light
  def initialize(position:, intensity: Colour.new(red: 1, green: 1, blue: 1))
    @position = position
    @intensity = intensity
  end

  attr_reader :position, :intensity

  def ambient
    return 0.15
  end

  def illuminate(object:, point:, world: )
    normal = object.normal_at(intersect: point)
    # move the intersection a small amount "up" to fix "acne" effects due to floating point rounding errors
    over_point = point.move!(vector: normal * 0.00000001)
    effective_colour = object.colour

    light_vector = (self.position.to_v - over_point.to_v)
    distance_to_light = light_vector.length
    in_shadow = point_in_shadow(over_point, light_vector, distance_to_light, world)

    ambient = effective_colour * self.ambient
    light_dot_normal = Vector.dot_product(light_vector.normalise!, normal)

    if light_dot_normal < 0 || in_shadow
      diffuse = Colour.black
    else
      diffuse = effective_colour * default_diffuse_reflection_factor * light_dot_normal
    end
    return ambient + diffuse
  end

  private def default_diffuse_reflection_factor
    return 1
  end

  private def point_in_shadow(point, light_vector, distance_to_light, world)
    shadow_ray = Ray.new(origin: point, direction: light_vector.normalise!)
    shadow_intersections = shadow_ray.trace(objects: world.objects)
    return shadow_intersections.select{ |intersection| intersection.t < distance_to_light }.count > 0
  end
end
