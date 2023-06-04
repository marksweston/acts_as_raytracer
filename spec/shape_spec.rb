RSpec.describe Shape do
  describe "#colour returns the colour at a particular point on the shape" do
    context "the shape just has a colour" do
      let(:shape) { Sphere.new(colour: Colour.white) }

      it "always returns the shape colour when the shape only has a single colour" do
        expect(shape.colour(at_point: Point.new(0,0,0))).to eq Colour.white
      end
    end

    context "the shape has a material which includes a pattern" do
      let(:pattern) { StripePattern.new(Colour.white, Colour.black) }
      let(:material) { Material.new(pattern: pattern) }
      let(:shape) { Sphere.new(material: material) }

      it "returns the colour based on the pattern at that point" do
        point = Point.new(0,0,0)
        expect(pattern).to receive(:at_object).with(object: shape, point: point).and_return Colour.white

        shape.colour(at_point: point)
      end
    end
  end
end
