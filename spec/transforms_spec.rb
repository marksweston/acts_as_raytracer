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

    it "multiplying by its inverse returns the original vector" do
      expect(transform.inverse * end_vector).to eq start_vector
    end
  end

  describe "Rotating" do
    it "rotates around the x axis" do
      point = Point.new(0, 1, 0)
      one_eigth_rotation = Transform::Rotation.new(axis: :x, angle: 0.25 * Math::PI)
      one_quarter_rotation = Transform::Rotation.new(axis: :x, angle: 0.5 * Math::PI)
      expect(one_quarter_rotation * point).to eq Point.new(0, 0, 1)
      expect(one_eigth_rotation * point).to eq Point.new(0, (Math.sqrt(2) / 2).round(epsilon), (Math.sqrt(2) / 2).round(epsilon))
    end

    it "rotates around the y axis" do
      point = Point.new(0, 0, 1)
      one_eigth_rotation = Transform::Rotation.new(axis: :y, angle: 0.25 * Math::PI)
      one_quarter_rotation = Transform::Rotation.new(axis: :y, angle: 0.5 * Math::PI)
      expect(one_quarter_rotation * point).to eq Point.new(1, 0, 0)
      expect(one_eigth_rotation * point).to eq Point.new((Math.sqrt(2) / 2).round(epsilon),0, (Math.sqrt(2) / 2).round(epsilon))
    end

    it "rotates around the z axis" do
      point = Point.new(0, 1, 0)
      one_eigth_rotation = Transform::Rotation.new(axis: :z, angle: 0.25 * Math::PI)
      one_quarter_rotation = Transform::Rotation.new(axis: :z, angle: 0.5 * Math::PI)
      expect(one_quarter_rotation * point).to eq Point.new(-1, 0, 0)
      expect(one_eigth_rotation * point).to eq Point.new(-(Math.sqrt(2) / 2).round(epsilon), (Math.sqrt(2) / 2).round(epsilon), 0)
      point = Point.new(1, 0, 0)
      expect(one_quarter_rotation * point).to eq Point.new( 0, 1, 0)
    end
  end

  describe "skewing" do
    it "can skew x in proportion to y" do
      skew = Transform::Skew.new(x_y: 1)
      point = Point.new(2, 3, 4)
      expect(skew * point).to eq Point.new(5, 3, 4)
    end

    it "can skew x in proportion to z" do
      skew = Transform::Skew.new(x_z: 1)
      point = Point.new(2, 3, 4)
      expect(skew * point).to eq Point.new(6, 3, 4)
    end

    it "can skew y in proportion to x" do
      skew = Transform::Skew.new(y_x: 1)
      point = Point.new(2, 3, 4)
      expect(skew * point).to eq Point.new(2, 5, 4)
    end

    it "can skew y in proportion to z" do
      skew = Transform::Skew.new(y_z: 1)
      point = Point.new(2, 3, 4)
      expect(skew * point).to eq Point.new(2, 7, 4)
    end

    it "can skew z in proportion to x" do
      skew = Transform::Skew.new(z_x: 1)
      point = Point.new(2, 3, 4)
      expect(skew * point).to eq Point.new(2, 3, 6)
    end

    it "can skew z in proportion to y" do
      skew = Transform::Skew.new(z_y: 1)
      point = Point.new(2, 3, 4)
      expect(skew * point).to eq Point.new(2, 3, 7)
    end
  end
end
