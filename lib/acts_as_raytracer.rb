require 'chunky_png'
require 'pry'
require 'matrix'

require_relative 'acts_as_raytracer/position'
require_relative 'acts_as_raytracer/scene'
require_relative 'acts_as_raytracer/film'
require_relative 'acts_as_raytracer/camera'
require_relative 'acts_as_raytracer/ray'
require_relative 'acts_as_raytracer/raster'
require_relative 'acts_as_raytracer/pixel'

scene = Scene.new(objects: [])

camera = Camera.new(
  position: Position[0,0,0],
  x_resolution: 100,
  y_resolution: 100
)

camera.shoot!(scene: scene)

puts "goodbye"
