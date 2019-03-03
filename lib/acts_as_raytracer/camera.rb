class Camera
  def initialize(position:, x_resolution:, y_resolution:)
    @position = position
    @x_resolution = x_resolution
    @y_resolution = y_resolution
    @film = Film.new(raster_width: x_resolution, raster_height: y_resolution)
  end

  attr_reader :position, :film, :x_resolution, :y_resolution
  attr_accessor :rays

  def shoot!(scene:)
    self.rays = film.get_primary_rays(origin: position, focal_length: focal_length)
    rays.each do |ray|
      ray.trace!(scene: scene)
    end
    film.develop!(rays)
  end

  def focal_length
    return 1
  end
end
