class World
  def initialize(objects:, light:)
    @objects = objects
    @light = light
  end

  attr_reader :objects, :light
  attr_accessor :intersections

  def trace(ray:)
    self.intersections = objects.map do |object|
      object.intersect(ray: ray)
    end.flatten.compact
    intersections.sort!{ |first_hit, second_hit| first_hit[:distance] <=> second_hit[:distance] }
    if intersections.empty?
      Colour.new(red: 0, green: 0, blue: 0)
    else
      effective_colour = intersections.first[:object].colour
      intersection_point = ray.position(distance: intersections.first[:distance])
      normal = intersections.first[:object].normal_at(intersect: intersection_point)
      light_vector = (light.position.to_v - intersection_point.to_v).normalise!
      ambient = effective_colour * light.ambient
      light_dot_normal = Vector.dot(light_vector, normal)
      over_point = intersection_point.move(vector: normal * 0.00001)
      if light_dot_normal < 0 || point_in_shadow(over_point, light_vector)
        diffuse = Colour.new(red: 0, green: 0, blue: 0)
      else
        diffuse = effective_colour * default_diffuse_reflection_factor * light_dot_normal
      end
      return ambient + diffuse
    end
  end

  def default_diffuse_reflection_factor
    return 1
  end

  def point_in_shadow(point, light_vector)
    shadow_ray = Ray.new(origin: point, direction: light_vector)
    shadow_intersections = objects.map do |object|
      object.intersect(ray: shadow_ray)
    end.flatten.compact
    return shadow_intersections.count > 0 && shadow_intersections.select{|int| int[:distance] > 0}.count > 0
  end
end
