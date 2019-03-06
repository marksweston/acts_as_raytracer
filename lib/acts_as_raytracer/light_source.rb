class LightSource
  def initialize(position:, intensity: Colour.new(red: 1, green: 1, blue: 1))
    @position = position
    @intensity = intensity
  end

  attr_reader :position, :intensity

  def ambient
    return 0.15
  end
end
