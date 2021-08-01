class Light
  def initialize(position:, intensity: Colour.white)
    @position = position
    @intensity = intensity
  end

  attr_reader :position, :intensity

  private def point_in_shadow?(point, light_vector, distance_to_light, world)
    shadow_ray = Ray.new(origin: point, vector: light_vector.normalise)
    shadow_intersections = shadow_ray.trace(objects: world.objects)
    return shadow_intersections.select{ |intersection| intersection.t < distance_to_light }.count > 0
  end
end
