class Plane
  def initialize(colour:)
    @colour = colour
  end

  attr_reader :colour

  def intersect(ray:)
    return nil if ray.direction[1].zero?
    t = (-ray.origin.y + self.y) / ray.direction[1]

    return [{:distance => t, :object => self}] if t > 0
  end

  def normal_at(intersect:)
    return Vector[0, 1, 0]
  end

  def reflect(incoming:, normal:)
    return incoming - normal * 2 * incoming.dot(normal)
  end

  def y
    return -0.1
  end
end
