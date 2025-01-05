class StripePattern < Pattern
  def initialize(first_colour:, second_colour:, transform: nil)
    super(transform)
    @first_colour = first_colour
    @second_colour = second_colour
  end

  attr_reader :first_colour, :second_colour

  def at(point:)
    if point.x % 2 < 1
      return first_colour
    else
      return second_colour
    end
  end
end
