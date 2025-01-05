class GradientPattern < Pattern
  attr_reader :first_colour, :second_colour
  
  def initialize(first_colour:, second_colour:, transform: nil)
    super(transform)
    @first_colour = first_colour
    @second_colour = second_colour
  end

  def at(point:)
    distance = second_colour - first_colour
    fraction = point.x - point.x.floor

    return first_colour + distance * fraction
  end
end 