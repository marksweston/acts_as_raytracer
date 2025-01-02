class SceneConfiguration
  def self.load_from_yaml(filename:)
    new(filename: filename)
  end

  def initialize(filename:)
    @scene_config = Psych.load_file(filename, aliases: true)
  end

  attr_reader :scene_config

  def generate_world
    objects = scene_config["world"]["objects"].map do |object_config|
      shape_type = object_config.keys.first
      material_config = object_config.values.first["material"]
      transform_config = object_config.values.first["transforms"]
      shape = create_shape(shape_type, material_config)
      apply_transforms(shape, transform_config) if transform_config
      
      shape
    end
    light = Light.new(position: Point.new(*scene_config["world"]["light"]["position"]))
    return World.new(objects: objects, light: light)
  end

  def create_camera
    camera_config = scene_config["camera"]
    return Camera.new(
      position: Point.new(*camera_config["position"]),
      x_resolution: camera_config["x_resolution"],
      y_resolution: camera_config["y_resolution"]
    )
  end

  private

  def create_shape(shape_type, material_config)
    material = create_material(material_config) if material_config
    
    case shape_type
    when "sphere"
      Sphere.new(material: material)
    when "plane"
      Plane.new(material: material) 
    else
      raise "Unknown shape type: #{object_config["type"]}"
    end
  end

  def create_material(material_config)
    Material.new(
      colour: create_colour(material_config["colour"]),
      ambient: material_config["ambient"],
      diffuse_reflection: material_config["diffuse_reflection"],
      specular_reflection: material_config["specular_reflection"],
      shininess: material_config["shininess"],
      pattern: create_pattern(material_config["pattern"]&.keys&.first,
      material_config["pattern"]&.values&.first)
    )
  end

  def create_colour(colour_config)
    return nil unless colour_config

    Colour.new(
      red: colour_config["red"],
      green: colour_config["green"],
      blue: colour_config["blue"]
    )
  end

  def create_pattern(pattern_type, pattern_config)
    return nil unless pattern_config

    StripePattern.new(
      create_colour(pattern_config["first_colour"]),
      create_colour(pattern_config["second_colour"]),
      create_transform(pattern_config["transform"])
    )
  end

  def create_transform(transform_config)
    return Transform::Identity.new if transform_config.nil?

    transform_type = transform_config.keys.first
    transform_params = transform_config.values.first
    case transform_type
    when "translate"
      Transform::Translation.new(x: transform_params["x"], y: transform_params["y"], z: transform_params["z"])
    when "scale"
      Transform::Scaling.new(x: transform_params["x"], y: transform_params["y"], z: transform_params["z"])
    end
  end


  def apply_transforms(shape, transforms)
    transforms.each do |transform|
      transform_type = transform.keys.first
      transform_params = transform.values.first

      case transform_type
      when "translate"
        shape.translate(x: transform_params["x"], y: transform_params["y"], z: transform_params["z"])
      when "scale"
        shape.scale(x: transform_params["x"], y: transform_params["y"], z: transform_params["z"])
      when "rotate"
        shape.rotate(axis: transform_params["axis"].to_sym, angle: transform_params["angle"] * Math::PI)
      when "skew"
        shape.skew(
          x_y: transform_params["x_y"].to_f,
          x_z: transform_params["x_z"].to_f,
          y_x: transform_params["y_x"].to_f,
          y_z: transform_params["y_z"].to_f,
          z_x: transform_params["z_x"].to_f,
          z_y: transform_params["z_y"].to_f
        )
      end
    end
  end
end
