RSpec.describe Colour do
  it "is a tuple of red, green and blue values" do
    colour = Colour.new(red: -0.5, green: 0.4, blue: 1.7)
    expect(colour.red).to eq -0.5
    expect(colour.green).to eq 0.4
    expect(colour.blue).to eq 1.7
  end

  describe "adding colours" do
    it "adds each colour component separately" do
      colour_1 = Colour.new(red: 0.9, green: 0.6, blue: 0.75)
      colour_2 = Colour.new(red: 0.7, green: 0.1, blue: 0.25)
      expect(colour_1 + colour_2).to eq Colour.new(red: 1.6, green: 0.7, blue: 1.0)
    end
  end

  describe "subtracting colours" do
    it "subtracts each colour component separately" do
      colour_1 = Colour.new(red: 0.9, green: 0.6, blue: 0.75)
      colour_2 = Colour.new(red: 0.7, green: 0.1, blue: 0.25)
      expect(colour_1 - colour_2).to eq Colour.new(red: 0.2, green: 0.5, blue: 0.5)
    end
  end

  describe "multiplying a colour by a scalar" do
    it "multiplies each colour component" do
      colour = Colour.new(red: 0.2, green: 0.3, blue: 0.4)
      expect(colour * 2).to eq Colour.new(red: 0.4, green: 0.6, blue: 0.8)
    end
  end

  describe "the Hadamard product of two colours" do
    it "multiplies each colour component from the two colours" do
      colour_1 = Colour.new(red: 1, green: 0.2, blue: 0.4)
      colour_2 = Colour.new(red: 0.9, green: 1, blue: 0.1)
      expect(colour_1.product colour_2).to eq Colour.new(red: 0.9, green: 0.2, blue: 0.04)
    end
  end

  describe "can be converted to an array of rgb values between 0 and 255" do
    it "converts colour values to rgb" do
      colour = Colour.new(red: 0, green: 0.499999, blue: 1)
      expect(colour.rgb).to eq [0, 127, 255]
    end

    it "clamps values greater than 1 to 1" do
      colour = Colour.new(red: 0, green: 0.499999, blue: 2.5)
      expect(colour.rgb).to eq [0, 127, 255]
    end

    it "clamps values less than 0 to 0" do
      colour = Colour.new(red: -0.8, green: 0.4999999, blue: 1)
      expect(colour.rgb).to eq [0, 127, 255]
    end
  end
end
