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
      return [0, 0, 0]
    else
      effective_colour = intersections.first[:object].colour
      intersection_point = ray.position(distance: intersections.first[:distance])
      normal = intersections.first[:object].normal_at(intersect: intersection_point)
      light_vector = (intersection_point.to_v - light.position.to_v).normalize
      ambient = (Vector.elements(effective_colour) * light.ambient).to_a
      ​light_dot_normal = light_vector.dot(normal)
      if ​light_dot_normal < 0
        diffuse = [0,0,0]
      else
        diffuse = (Vector.elements(effective_colour) * 1 * ​light_dot_normal).to_a
      end
      colour = (Vector.elements(ambient) + Vector.elements(diffuse)).to_a
      return colour.map{|element| element.round.clamp 0, 255}
    end
  end
end
