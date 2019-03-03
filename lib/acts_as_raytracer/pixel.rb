class Pixel
  def initialize(position: nil, x: nil, y: nil, red: 0, green: 0, blue: 0)
    raise "requires either a Position or co-ordinates" if position.nil? && (x.nil? || y.nil?)

    @x = position&.x || x
    @y = position&.y || y
    @red = red
    @green = green
    @blue = blue
  end

  attr_reader :x, :y, :red, :green, :blue
  attr_writer :red, :green, :blue

  def set_colours(colour_array:)
    self.red, self.green, self.blue = colour_array
  end
end
