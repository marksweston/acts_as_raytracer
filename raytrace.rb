require_relative 'lib/acts_as_raytracer'

world = World.new(
    objects: [
        Plane.new(colour: Colour.new(red: 0.9, green: 0.9, blue: 0.9))
            .rotate(axis: :x, angle: -Math::PI / 2)
            .rotate(axis: :y, angle: -Math::PI / 4)
            .translate(x: 0, y: 0, z: 7),
        Plane.new(colour: Colour.new(red: 0.9, green: 0.9, blue: 0.9))
            .rotate(axis: :x, angle: -Math::PI / 2)
            .rotate(axis: :y, angle: Math::PI / 4)
            .translate(x: 0, y: 0, z: 7),
        Plane.new(colour: Colour.new(red: 0.9, green: 0.9, blue: 0.9))
            .translate(x: 0, y: -1, z: 0),
        Sphere.new(colour: Colour.new(red: 1, green: 0, blue: 0))
            .scale(x: 0.5, y: 0.2, z: 1.5)
            .translate(x: 1.5, y: 0.5, z: 3),
        Sphere.new(colour: Colour.new(red: 0, green: 1, blue: 0))
            .scale(x: 0.75, y: 0.75, z: 1)
            .translate(x: 0, y: 1, z: 3),
    ],
    light: Light.new(position: Point.new(0 , 1, -2))
)

camera = Camera.new(
    position: Point.new(0,0,0),
    x_resolution: 1000,
    y_resolution: 1000
)

camera.shoot!(world: world)

