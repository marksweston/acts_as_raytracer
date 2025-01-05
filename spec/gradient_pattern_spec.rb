RSpec.describe GradientPattern do
  it "returns a gradient pattern" do
    expect(GradientPattern.new(first_colour: Colour.white, second_colour: Colour.black)).to be_a(GradientPattern)
  end

  describe "a GradientPattern returns a colour somewhere on a smooth gradient between two colours" do
    it "returns the first colour when x = 0" do
      expect(GradientPattern.new(
        first_colour: Colour.white, 
        second_colour: Colour.black).
        at(point: Point.new(0, 0, 0))).
        to eq Colour.white
    end

    it "returns 25% of the way between the first and second colour when x = 0.25" do
      expect(GradientPattern.new(
        first_colour: Colour.white, 
        second_colour: Colour.black).
        at(point: Point.new(0.25, 0, 0))).
        to eq Colour.new(red: 0.75, green: 0.75, blue: 0.75)
    end

    it "returns 50% of the way between the first and second colour when x = 0.5" do
      expect(GradientPattern.new(
        first_colour: Colour.white, 
        second_colour: Colour.black).
        at(point: Point.new(0.5, 0, 0))).
        to eq Colour.new(red: 0.5, green: 0.5, blue: 0.5)
    end

    it "returns 75% of the way between the first and second colour when x = 0.75" do
      expect(GradientPattern.new(
        first_colour: Colour.white, 
        second_colour: Colour.black).
        at(point: Point.new(0.75, 0, 0))).
        to eq Colour.new(red: 0.25, green: 0.25, blue: 0.25)
    end

    it "cycles back to the first colour when x = 1" do
      expect(GradientPattern.new(
        first_colour: Colour.white, 
        second_colour: Colour.black).
        at(point: Point.new(1, 0, 0))).
        to eq Colour.white
    end
  end
end
