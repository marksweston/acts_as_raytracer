class Plane < Shape
  def intersect(ray:)
    return [] if object_space(ray).direction.y.round(epsilon).zero?

    t = (-object_space(ray).origin.y) / object_space(ray).direction.y
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
