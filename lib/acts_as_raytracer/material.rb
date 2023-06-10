class Material
  def self.default_values
    return {
      colour: Colour.black,
      ambient: 0.15,
      diffuse_reflection: 0.9,
      specular_reflection: 0.9,
      shininess: 20
    }
  end

  def initialize(colour: nil, ambient: nil, diffuse_reflection: nil, specular_reflection: nil, shininess: nil, pattern: nil)
    @colour = colour || Material.default_values[:colour]
    @ambient = ambient || Material.default_values[:ambient]
    @diffuse_reflection = diffuse_reflection || Material.default_values[:diffuse_reflection]
    @specular_reflection = specular_reflection || Material.default_values[:specular_reflection]
    @shininess = shininess || Material.default_values[:shininess]
    @pattern = pattern
  end

  attr_reader :ambient, :diffuse_reflection, :specular_reflection, :shininess, :pattern

  def colour(object_space_point:)
    if pattern
      return pattern.colour_at(object_space_point: object_space_point)
    else
      return @colour
    end
  end
end
