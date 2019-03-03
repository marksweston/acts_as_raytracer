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

world = World.new(objects: [])

camera = Camera.new(
  position: Position[0,0,0],
  x_resolution: 100,
  y_resolution: 100
)

camera.shoot!(world: world)

puts "goodbye"
