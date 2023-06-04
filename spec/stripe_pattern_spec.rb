RSpec.describe StripePattern do
  describe "A stripe pattern determines the colour of an object based on the value of the x co-ordinate of the hit point" do
    let(:stripe) { StripePattern.new(Colour.white, Colour.black) }
    describe "#at returns the colour at a particular x, y, z co-ordinate" do
      describe "the stripe pattern returns a constant colour on the y axis" do
        it "always returns white if x = 0, whatever the y co-ordinate" do
          expect(stripe.at(point: Point.new(0, 0, 0))).to eq Colour.white
          expect(stripe.at(point: Point.new(0, -1, 0))).to eq Colour.white
          expect(stripe.at(point: Point.new(0, 2, 0))).to eq Colour.white
        end
      end

      describe "the stripe pattern returns a constant colour on the z axis" do
        it "always returns white if x = 0, whatever the z co-ordinate" do
          expect(stripe.at(point: Point.new(0, 0, 0))).to eq Colour.white
          expect(stripe.at(point: Point.new(0, 0, -1))).to eq Colour.white
          expect(stripe.at(point: Point.new(0, 0, 2))).to eq Colour.white
        end
      end

      describe "the stripe pattern returns the first colour or second colour depending on the x co-ordinate" do
        it "returns white if x mod 2 < 1" do
          expect(stripe.at(point: Point.new(0, 0, 0))).to eq Colour.white
          expect(stripe.at(point: Point.new(2, 0, 0))).to eq Colour.white
          expect(stripe.at(point: Point.new(0.99, 0, 0))).to eq Colour.white
          expect(stripe.at(point: Point.new(-1.99, 0, 0))).to eq Colour.white
          expect(stripe.at(point: Point.new(10.99, 0, 0))).to eq Colour.white
        end

        it "returns black if x mod 2 >= 1" do
          expect(stripe.at(point: Point.new(1, 0, 0))).to eq Colour.black
          expect(stripe.at(point: Point.new(-0.1, 0, 0))).to eq Colour.black
          expect(stripe.at(point: Point.new(1.99, 0, 0))).to eq Colour.black
          expect(stripe.at(point: Point.new(-0.99, 0, 0))).to eq Colour.black
          expect(stripe.at(point: Point.new(11.99, 0, 0))).to eq Colour.black
        end
      end
    end

    describe "effects of transformations on patterns" do
      describe "#at_object returns the colour for this stripe pattern as modified by an objects transformations" do
        let(:material) {Material.new(pattern: stripe)}
        let(:object) {Sphere.new(material: material).scale(x: 2, y: 2, z: 2)}

        it "returns white when the stripe is transformed" do
          point = Point.new(1.5, 0, 0)

          expect(stripe.at(point: point)).to eq Colour.black
          expect(stripe.at_object(object: object, point: point)).to eq Colour.white
        end
      end

      describe "#at_object returns the colour for this stripe pattern as modified by a pattern transformation" do
        let(:scaled_stripe) { StripePattern.new(Colour.white, Colour.black, transform: Transform::Scaling.new(x: 2, y: 2, z:2)) }
        let(:object) {Sphere.new(material: Material.new(pattern: scaled_stripe))}

        it "returns white when the stripe is transformed" do
          point = Point.new(1.5, 0, 0)

          expect(stripe.at(point: point)).to eq Colour.black
          expect(scaled_stripe.at_object(object: object, point: point)).to eq Colour.white
        end
      end

      describe "object and pattern transformations can combine and counterract each other" do
        context "an object transformation that doubles the size of the intervals and a pattern transformation that halves them" do
          let(:scaled_times_two) { Transform::Scaling.new(x: 2, y: 2, z: 2) }
          let(:doubled_stripe) { StripePattern.new(Colour.white, Colour.black, transform: scaled_times_two) }
          let(:object) {Sphere.new(material: Material.new(pattern: doubled_stripe)).scale(x: 0.5, y: 0.5, z: 0.5) }

          it 'they cancel out and produce stripes that are 1 unit wide' do
            point_one = Point.new(0.5, 0, 0)
            point_two = Point.new(1.5, 0, 0)

            expect(doubled_stripe.at_object(object: object, point: point_one)).to eq Colour.white
            expect(doubled_stripe.at_object(object: object, point: point_two)).to eq Colour.black
          end
        end
      end
    end
  end
end
