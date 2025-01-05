require 'chunky_png'
require 'pry-byebug'
require 'forwardable'
require 'rmath3d/rmath3d'
require 'psych'

include RMath3D

def epsilon
  return 11
end

require_relative 'acts_as_raytracer/world'
require_relative 'acts_as_raytracer/film'
require_relative 'acts_as_raytracer/camera'
require_relative 'acts_as_raytracer/ray'
require_relative 'acts_as_raytracer/raster'
require_relative 'acts_as_raytracer/pixel'
require_relative 'acts_as_raytracer/shape'
require_relative 'acts_as_raytracer/sphere'
require_relative 'acts_as_raytracer/light'
require_relative 'acts_as_raytracer/colour'
require_relative 'acts_as_raytracer/plane'
require_relative 'acts_as_raytracer/point'
require_relative 'acts_as_raytracer/vector'
require_relative 'acts_as_raytracer/transform'
require_relative 'acts_as_raytracer/translation'
require_relative 'acts_as_raytracer/scaling'
require_relative 'acts_as_raytracer/identity'
require_relative 'acts_as_raytracer/rotation'
require_relative 'acts_as_raytracer/skew'
require_relative 'acts_as_raytracer/intersection'
require_relative 'acts_as_raytracer/material'
require_relative 'acts_as_raytracer/pattern'
require_relative 'acts_as_raytracer/gradient_pattern'
require_relative 'acts_as_raytracer/stripe_pattern'
require_relative 'acts_as_raytracer/scene_configuration'

