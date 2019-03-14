class Ray
  def initialize(origin:, direction:, position_on_film: nil)
    @origin = origin
    @direction = direction
    @position_on_film = position_on_film
  end

  attr_reader :origin, :direction, :position_on_film
  attr_accessor :colour

  def at(t:)
    change_vector = direction * t
    return Point.new(
      origin.x + change_vector.x,
      origin.y + change_vector.y,
      origin.z + change_vector.z
    )
  end

  def to_s
    return "origin: #{origin} - direction: #{direction}"
  end
end
