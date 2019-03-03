class Raster
  def initialize(width:, height:)
    @width = width
    @height = height
    @pixels = (0..(height - 1)).map do |y|
      (0..(width - 1)).map do |x|
        Pixel.new(x: x, y: y)
      end
    end
  end

  attr_reader :height, :width

  def set_pixel(pixel:)
    @pixels[pixel.y][pixel.x] = pixel
  end

  def pixels
    return @pixels.flatten
  end

  def save
    png = ChunkyPNG::Image.new(width, height)
    pixels.each do |pixel|
      png[pixel.x, pixel.y] = ChunkyPNG::Color.rgb(pixel.red, pixel.green, pixel.blue)
    end
    png.save("render-#{Time.now.to_i}.png", :interlace => true)
  end
end
