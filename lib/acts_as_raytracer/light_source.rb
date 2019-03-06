class LightSource
  def initialize(position:, intensity: [255, 255, 255])
    @position = position
    @intensity = intensity
  end

  attr_reader :position, :intensity

  def ambient
    return 0.15
  end
end
