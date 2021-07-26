class Colour
  def self.black
    return new(red: 0, green: 0, blue: 0)
  end

  def self.white
    return new(red: 1, green: 1, blue: 1)
  end

  def initialize(red:, green:, blue:)
    @red = red
    @green = green
    @blue = blue
  end

  attr_reader :red, :green, :blue

  def ==(other_colour)
    red.round(8) == other_colour.red.round(8) and
    green.round(8) == other_colour.green.round(8) and
    blue.round(8) == other_colour.blue.round(8)
  end

  def +(other_colour)
    return Colour.new(
       red: red + other_colour.red,
       green: green + other_colour.green,
       blue: blue + other_colour.blue
    )
  end

  def -(other_colour)
    return Colour.new(
       red: red - other_colour.red,
       green: green - other_colour.green,
       blue: blue - other_colour.blue
    )
  end

  def *(scalar)
    return Colour.new(
      red: red * scalar,
      green: green * scalar,
      blue: blue * scalar
    )
  end

  def product(other_colour)
    return Colour.new(
        red: red * other_colour.red,
        green: green * other_colour.green,
        blue: blue * other_colour.blue
    )
  end

  def rgb
    return [
      (red * 255).round.clamp(0,255),
      (green * 255).round.clamp(0,255),
      (blue * 255).round.clamp(0,255)
    ]
  end

  def to_s
    return "red: #{red} - green: #{green} - blue: #{blue}"
  end
end
