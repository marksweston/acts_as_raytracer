RSpec.describe Vector do
  describe "subtracting one vector from another" do
    it "returns a new vector in which each element is the result of subtracting element 2 from element 1" do
      vector1 = Vector.new(1, 2, 3)
      vector2 = Vector.new(3, 2, 1)
      expect(vector1 - vector2).to eq Vector.new(-2, 0, 2)
    end
  end

  describe "multiplying a vector by a scalar" do
    it "returns a new vector where each element has been multiplied by the scalar" do
      vector = Vector.new( -1, 0, 1)
      expect(vector * 2.5).to eq Vector.new(-2.5, 0, 2.5)
    end
  end

  describe "a vector has a scalar magnitude" do
    it "(1, 0 ,0) has a magnitude of 1" do
      vector = Vector.new(1, 0, 0)
      expect(vector.magnitude).to eq 1
    end

    it "(0, 1 ,0) has a magnitude of 1" do
      vector = Vector.new(0, 1, 0)
      expect(vector.magnitude).to eq 1
    end

    it "(0, 0 , 1) has a magnitude of 1" do
      vector = Vector.new(0, 0, 1)
      expect(vector.magnitude).to eq 1
    end

    it "(1, 2, 3) has a magnitude of sqrt(14) - thanks Pythagoras" do
      vector = Vector.new(1, 2, 3)
      expect(vector.magnitude).to eq Math.sqrt(14)
    end

    it "(-1, -2, -3) also has a magnitude of sqrt(14)" do
      vector = Vector.new(-1, -2, -3)
      expect(vector.magnitude).to eq Math.sqrt(14)
    end
  end

  describe "normalising a vector returns a unit vector" do
    it "normalising (4, 0, 0) returns the unit vector (1, 0, 0)" do
      vector = Vector.new(4, 0, 0)
      expect(vector.normalise).to eq Vector.new(1, 0 , 0)
    end

    it "normalising (1, 2, 3) returns a unit vector with magnitude 1" do
      vector = Vector.new(1, 2, 3)
      expect(vector.normalise.magnitude).to eq 1
    end
  end

  describe "returning a dot product of a vector and another vector" do
    it "calculates a dot product of the two vectors" do
      vector1 = Vector.new(1, 2, 3)
      vector2 = Vector.new(2, 3, 4)
      expect(vector1.dot_product(vector2)).to eq 20
    end
  end
end
