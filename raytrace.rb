require_relative 'lib/acts_as_raytracer'

world = World.new(objects: [
    Sphere.new(position: Position[1,1,3], radius: 1, colour: Colour.new(red: 1, green: 0, blue: 0)),
    Sphere.new(position: Position[0,0,3], radius: 1.5, colour: Colour.new(red: 0, green: 1, blue: 0)),],
                  light: LightSource.new(position: Position[-5,10,-3]))

camera = Camera.new(
    position: Position[0,0,0],
    x_resolution: 200,
    y_resolution: 200
)

camera.shoot!(world: world)

puts "goodbye"
