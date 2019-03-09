class Ray
  def initialize(origin:, direction:, position_on_film: nil)
    @origin = origin
    @direction = direction
    @position_on_film = position_on_film
  end

  attr_reader :origin, :direction, :position_on_film
  attr_accessor :colour

  def position(distance:)
    change_vector = direction * distance
    return Position[
      origin.x + change_vector[0],
      origin.y + change_vector[1],
      origin.z + change_vector[2]
    ]
  end

  def to_s
    return "origin: #{origin} - direction: #{direction}"
  end
end
