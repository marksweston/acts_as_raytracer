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
  end
end
