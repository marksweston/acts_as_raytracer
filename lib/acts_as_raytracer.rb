require 'chunky_png'
require 'pry'
require 'matrix'

require_relative 'acts_as_raytracer/position'
require_relative 'acts_as_raytracer/world'
require_relative 'acts_as_raytracer/film'
require_relative 'acts_as_raytracer/camera'
require_relative 'acts_as_raytracer/ray'
require_relative 'acts_as_raytracer/raster'
require_relative 'acts_as_raytracer/pixel'
require_relative 'acts_as_raytracer/sphere'
require_relative 'acts_as_raytracer/light_source'

world = World.new(objects: [
    Sphere.new(position: Position[1,1,3], radius: 1, colour: [255, 0, 0]),
    Sphere.new(position: Position[0,0,3], radius: 1.5, colour: [0, 255, 0]),],
                  light: LightSource.new(position: Position[-5,10,-3]))

camera = Camera.new(
  position: Position[0,0,0],
  x_resolution: 200,
  y_resolution: 200
)

camera.shoot!(world: world)

puts "goodbye"
