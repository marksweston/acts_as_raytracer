RSpec.describe Plane do
  describe "#intersect" do
    let(:plane) { Plane.new }

    it "doesn't intersect with a parallel ray" do
      ray = Ray.new(origin: Point.new(0,10, 0), direction: Vector.new(0, 0, 1))
      expect(plane.intersect(ray: ray)).to be_nil
    end

    it "doesn't intersect with a coplanar ray" do
      ray = Ray.new(origin: Point.new(0,0, 0), direction: Vector.new(0, 0, 1))
      expect(plane.intersect(ray: ray)).to be_nil
    end

    it "intersects from above" do
      ray = Ray.new(origin: Point.new(0,1, 0), direction: Vector.new(0, -1, 1))
      expect(plane.intersect(ray: ray).count).to eq 1
    end

    it "intersects from below" do
      ray = Ray.new(origin: Point.new(0,-1, 0), direction: Vector.new(0, 1, 1))
      expect(plane.intersect(ray: ray).count).to eq 1
    end
  end
end
