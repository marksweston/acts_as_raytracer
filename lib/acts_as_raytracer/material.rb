class Material
  def initialize(ambient:, diffuse_reflection:, specular_reflection:, shininess:)
    @ambient = ambient
    @diffuse_reflection = diffuse_reflection
    @specular_reflection = specular_reflection
    @shininess = shininess
  end

  attr_reader :ambient, :diffuse_reflection, :specular_reflection, :shininess
end
