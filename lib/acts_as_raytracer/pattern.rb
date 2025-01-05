class Pattern
  def initialize(transform = Transform::Identity.new)
    @transform = transform
  end

  attr_reader :transform

  def colour_at(object_space_point:)
    point_in_pattern_space = self.transform.inverse * object_space_point

    return self.at(point: point_in_pattern_space)
  end
end
