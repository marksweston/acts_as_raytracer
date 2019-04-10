require_relative 'lib/acts_as_raytracer'

world = World.new(objects: [
    Plane.new(colour: Colour.new(red: 0.8, green: 0.7, blue: 0.7)),
    Sphere.new(colour: Colour.new(red: 1, green: 0, blue: 0))
          .scale(x: 1.5, y: 0.2, z: 1.5)
          .translate(x: 1.75, y: 0.8, z: 4),
    Sphere.new(colour: Colour.new(red: 0, green: 1, blue: 0))
          .scale(x: 1.5, y: 1.5, z: 1.5)
          .skew(x_y: 0.75)
          .translate(x: -0.2, y: 1.6, z: 4),
    ],
    light: LightSource.new(position: Point.new(8, 3, -5)))

camera = Camera.new(
    position: Point.new(0,0,0),
    x_resolution: 400,
    y_resolution: 400
)

camera.shoot!(world: world)

puts "goodbye"
