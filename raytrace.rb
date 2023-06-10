require_relative 'lib/acts_as_raytracer'

world = World.new(
    objects: [
        Plane.new(material: Material.new(pattern: StripePattern.new(Colour.white, Colour.black)))
            .rotate(axis: :x, angle: -Math::PI / 2)
            .rotate(axis: :y, angle: -Math::PI / 4)
            .translate(x: 0, y: 0, z: 7),
        Plane.new(material: Material.new(pattern: StripePattern.new(Colour.white, Colour.black)))
            .rotate(axis: :x, angle: -Math::PI / 2)
            .rotate(axis: :y, angle: Math::PI / 4)
            .translate(x: 0, y: 0, z: 7),
        Plane.new(material: Material.new(pattern: StripePattern.new(Colour.white, Colour.black)))
            .translate(x: 0, y: -1, z: 0),
        Sphere.new(material: Material.new(colour: Colour.new(red: 1, green: 0, blue: 0)))
            .scale(x: 0.5, y: 0.2, z: 1.5)
            .translate(x: 1.5, y: 1, z: 3),
        Sphere.new(material: Material.new(colour: Colour.new(red: 1, green: 0.843, blue: 0),
                                          ambient: 0.15,
                                          diffuse_reflection: 1.2,
                                          specular_reflection: 0.9,
                                          shininess: 10))
            .translate(x: 0.5, y: -0.5, z: 2),
        Sphere.new(material: Material.new(colour: Colour.new(red: 0, green: 1, blue: 0),
                                          ambient: 0.15,
                                          diffuse_reflection: 0.9,
                                          specular_reflection: 0.3,
                                          shininess: 5,
                                          pattern: StripePattern.new(Colour.new(red: 0, green: 1, blue: 0),
                                                                     Colour.new(red: 0, green: 0.5, blue: 0),
                                                                     transform: Transform::Scaling.new(x: 0.25, y: 0.25, z:0.25))))
            .scale(x: 1.5, y: 1.5, z: 1.5)
            .translate(x: -1, y: 1, z: 3),
    ],
    light: Light.new(position: Point.new(0 , 1, -1))
)

camera = Camera.new(
    position: Point.new(0,0,0),
    x_resolution: 300,
    y_resolution: 300
)

camera.shoot!(world: world)

#
