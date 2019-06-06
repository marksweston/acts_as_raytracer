require_relative 'lib/acts_as_raytracer'

world = World.new(
    objects: [
    Plane.new(colour: Colour.new(red: 1, green: 1, blue: 1))
        .rotate(axis: :x, angle: -Math::PI / 2)
        .translate(x: 0, y: 0, z: 5),
    # Plane.new(colour: Colour.new(red: 0.9, green: 0.9, blue: 0.9))
    #     .rotate(axis: :y, angle: 2),
    Sphere.new(colour: Colour.new(red: 1, green: 0, blue: 0))
              .scale(x: 1.5, y: 0.2, z: 1.5)
              .translate(x: 1.75, y: 0.8, z: 4),
    Sphere.new(colour: Colour.new(red: 0, green: 1, blue: 0))
          .scale(x: 1.5, y: 1.5, z: 1.5)
          .skew(x_y: 0.75)
          .translate(x: -0.2, y: 1.6, z: 4),
        ],
    light: LightSource.new(position: Point.new(2, 2, -2))
)

camera = Camera.new(
    position: Point.new(0,0,0),
    x_resolution: 1000,
    y_resolution: 1000
)

camera.shoot!(world: world)

puts "goodbye"
