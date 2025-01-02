require 'spec_helper'

RSpec.describe SceneConfiguration do
  describe '#create_camera' do
    it 'creates a camera with correct attributes from yaml configuration' do
      scene_config = SceneConfiguration.load_from_yaml(filename: 'spec/scene_fixture.yml')
      
      camera = scene_config.create_camera
      
      expect(camera).to be_a(Camera)
      expect(camera.position).to eq(Point.new(0, 0, 0))
      expect(camera.x_resolution).to eq(300)
      expect(camera.y_resolution).to eq(300)
    end
  end

  describe '#generate_world' do
    it 'creates a valid world instance from yaml configuration' do
      scene_config = SceneConfiguration.load_from_yaml(filename:'spec/scene_fixture.yml')
      
      world = scene_config.generate_world
      
      expect(world).to be_a(World)
    end

    it 'creates a world with a light' do
      scene_config = SceneConfiguration.load_from_yaml(filename:'spec/scene_fixture.yml')
      
      world = scene_config.generate_world
      
      expect(world.light).to be_a(Light)
    end

    it 'creates a world with the correct number of objects' do
      scene_config = SceneConfiguration.load_from_yaml(filename:'spec/scene_fixture.yml')
      
      world = scene_config.generate_world
      
      expect(world.objects.count).to eq(6)
    end

    it 'creates a world with the correct objects' do
      scene_config = SceneConfiguration.load_from_yaml(filename:'spec/scene_fixture.yml')
      
      world = scene_config.generate_world
      
      expect(world.objects.count { |obj| obj.is_a?(Plane) }).to eq(3)
      expect(world.objects.count { |obj| obj.is_a?(Sphere) }).to eq(3)
    end

    it 'creates the first Plane with 3 transforms' do
      scene_config = SceneConfiguration.load_from_yaml(filename:'spec/scene_fixture.yml')
      
      world = scene_config.generate_world
      
      plane = world.objects.first
      expect(plane).to be_a(Plane)
      expect(plane.transforms.count).to eq(3)
      expect(plane.transforms.map(&:class)).to eq([Transform::Rotation, Transform::Rotation, Transform::Translation])
    end
  end

  it 'creates the first Sphere with 2 transforms' do
    scene_config = SceneConfiguration.load_from_yaml(filename:'spec/scene_fixture.yml')
    
    world = scene_config.generate_world
    
    sphere = world.objects[3]
    expect(sphere).to be_a(Sphere)
    expect(sphere.transforms.count).to eq(2)
    expect(sphere.transforms.map(&:class)).to eq([Transform::Scaling, Transform::Translation])
  end
end 