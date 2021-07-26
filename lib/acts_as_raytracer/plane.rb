class Plane < Shape
  def self.default_material
    return Material.new(
      ambient: 0.30,
      diffuse_reflection: 0.9,
      specular_reflection: 0,
      shininess: 0
    )
  end

  def intersect(ray:)
    return [] if object_space(ray).vector.y.round(epsilon).zero?

    t = (-object_space(ray).origin.y) / object_space(ray).vector.y
    if t > 0
      return [Intersection.new(t: t, object: self)]
    else
      return []
    end
  end

  def normal_at(intersect:)
    return world_space(Vector.new(0, 1, 0)).normalise
  end
end
