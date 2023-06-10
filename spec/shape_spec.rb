RSpec.describe Shape do
  describe "#colour delegates to the shapes material" do

    it "does" do
      material = Material.new(colour: Colour.white)
      shape = Sphere.new(material: material)
      expect(material).to receive(:colour)

      shape.colour(at_point: Point.new(0,0,0))
    end
  end
end
