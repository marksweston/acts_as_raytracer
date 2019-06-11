class World
  def initialize(objects:, light:)
    @objects = objects
    @light = light
  end

  attr_reader :objects, :light
  attr_accessor :intersections

  def trace(ray:)
    intersections = ray.trace(objects: objects)
    return Colour.black if intersections.empty?

    intersection_point = ray.at(t: intersections.first.t)
    normal = intersections.first.object.normal_at(intersect: intersection_point)
    light_vector = (light.position.to_v - intersection_point.to_v)
    distance_to_light = light_vector.length
    over_point = intersection_point.move(vector: normal * 0.00001)
    in_shadow = point_in_shadow(over_point, light_vector, distance_to_light)
    effective_colour = intersections.first.object.colour
    ambient = effective_colour * light.ambient
    light_dot_normal = Vector.dot_product(light_vector.normalise!, normal)

    if light_dot_normal < 0 || in_shadow
      diffuse = Colour.new(red: 0, green: 0, blue: 0)
    else
      diffuse = effective_colour * default_diffuse_reflection_factor * light_dot_normal
    end
    return ambient + diffuse
  end

  def default_diffuse_reflection_factor
    return 1
  end

  def point_in_shadow(point, light_vector, distance_to_light)
    shadow_ray = Ray.new(origin: point, direction: light_vector.normalise!)
    shadow_intersections = shadow_ray.trace(objects: objects)
    return shadow_intersections.select{ |intersection| intersection.t < distance_to_light }.count > 0
  end
end
