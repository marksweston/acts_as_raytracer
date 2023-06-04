class StripePattern
  def initialize(first_colour, second_colour, transform: Transform::Identity.new)
    @first_colour = first_colour
    @second_colour = second_colour
    @transform = transform
  end

  attr_reader :first_colour, :second_colour, :transform

  def at(point:)
    if point.x % 2 < 1
      return first_colour
    else
      return second_colour
    end
  end

  def at_object(object:, point:)
    point_in_object_space = object.combined_transform.inverse * point
    point_in_pattern_space = self.transform.inverse * point_in_object_space

    return self.at(point: point_in_pattern_space)
  end
end
