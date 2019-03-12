RSpec.describe "Transforms" do
  describe "Translations" do
    let(:transform) { Transform::Translation.new(x: 1, y: 1, z: 10) }
    let(:starting_point) { Point.new(0, 0, -5) }
    let(:end_point) { Point.new(1, 1, 5) }

    it "changes a Point by the specified values" do
      expect(transform * starting_point).to eq end_point
    end

    it "multiplying by its inverse returns the original Point" do
      expect(transform.inverse * end_point).to eq starting_point
    end

    it "doesn't affect a Vector" do
      vector = Vector.new(2, 3, 4)
      expect(transform * vector).to eq vector
    end
  end

  describe "Scaling" do
    let(:transform) { Transform::Scaling.new(x: 2, y: 2, z: 2) }
    let(:start_vector) { Vector.new(2, 3, -4) }
    let(:end_vector) { Vector.new(4, 6, -8) }

    it "scales a vector by the specified values" do
      expect(transform * start_vector).to eq end_vector
    end

    it "multiplying by its inverse returns the origin vector" do
      expect(transform.inverse * end_vector).to eq start_vector
    end
  end
end
