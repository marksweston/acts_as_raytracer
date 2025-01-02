require_relative 'lib/acts_as_raytracer'

scene = SceneConfiguration.load_from_yaml(filename: "test_scene.yml")

world = scene.generate_world
camera = scene.create_camera

camera.shoot!(world: world)

