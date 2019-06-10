class Plane < Shape
  def intersect(ray:)
    return nil if object_space(ray).direction.y.round(12).zero?
    t = (-object_space(ray).origin.y) / object_space(ray).direction.y

    return [{:t => t , :object => self}] if t > 0
  end

  def normal_at(intersect:)
    return world_space(Vector.new(0, 1, 0)).normalise!
  end
end
