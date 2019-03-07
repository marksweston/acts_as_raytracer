require_relative 'lib/acts_as_raytracer'

world = World.new(objects: [
    Plane.new(colour: Colour.new(red: 0.8, green: 0.7, blue: 0.7)),
    Sphere.new(position: Position[2, 3, 6], radius: 1, colour: Colour.new(red: 1, green: 0, blue: 0)),
    Sphere.new(position: Position[0, 2, 5], radius: 1.5, colour: Colour.new(red: 0, green: 1, blue: 0)), ],
                  light: LightSource.new(position: Position[-5, 10, 0]))

camera = Camera.new(
    position: Position[0,0,0],
    x_resolution: 200,
    y_resolution: 200
)

camera.shoot!(world: world)

puts "goodbye"
