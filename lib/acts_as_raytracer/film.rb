class Film
  def initialize(raster_width:, raster_height:)
    @raster = Raster.new(width: raster_width, height: raster_height)
  end

  attr_reader :raster

  def get_primary_rays(origin:, focal_length:)
    raster.pixels.map do |pixel|
      pixel_position = map_pixel_to_film_position(pixel)
      Ray.new(
          origin: origin,
          direction: Vector[pixel_position.x, pixel_position.y, origin.z + focal_length].normalize,
          position_on_film: pixel_position
      )
    end
  end

  def develop!(rays)
    rays.each do |ray|
      pixel = map_film_position_to_pixel(ray.position_on_film)
      pixel.set_colours(colour_array: ray.colour)
      raster.set_pixel(pixel: pixel)
    end
    raster.save
  end

  def map_pixel_to_film_position(pixel)
    return Position[
      (pixel.x + 0.5) / raster.width * width - (width / 2),
      (pixel.y + 0.5) / raster.height * height - (height / 2),
      0
    ]
  end

  def map_film_position_to_pixel(film_position)
    return Pixel.new(
      x: ((film_position.x + width / 2) * raster.width / width - 0.5).round,
      y: ((film_position.y + height / 2) * raster.height / height - 0.5).round,
    )
  end

  def width
    return 2
  end

  def height
    return 2
  end
end
