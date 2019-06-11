RSpec.describe Sphere do
  describe "testing whether rays #intersect this sphere" do
    it "should intersect" do
      ray = Ray.new(origin: Point.new(0, 0, -5), direction: Vector.new(0, 0, 1))
      sphere = Sphere.new.scale(x: 2, y: 2, z: 2)
      intersections = sphere.intersect ray: ray
      expect(intersections.first.t).to eq 3
      expect(intersections.last.t).to eq 7
    end

    it "should not change the origin ray" do
      ray = Ray.new(origin: Point.new(0, 0, -5), direction: Vector.new(0, 0, 1))
      sphere = Sphere.new.scale(x: 2, y: 2, z: 2)
      intersections = sphere.intersect ray: ray
      expect(ray.origin).to eq Point.new(0, 0, -5)
      expect(ray.direction).to eq Vector.new(0, 0, 1)
    end
  end

  describe "returning a #normal_at a point on the sphere's surface" do
    it "should be < 1, 0, 0> at point (1, 0, 0) for a unit sphere" do
      sphere = Sphere.new
      point = Point.new(1,0,0)
      expect(sphere.normal_at(intersect: point)).to eq Vector.new(1, 0, 0)
    end

    it "should be <0, -1, 0> at point (0, -1, 0) for a unit sphere" do
      sphere = Sphere.new
      point = Point.new(0,-1,0)
      expect(sphere.normal_at(intersect: point)).to eq Vector.new(0, -1, 0)
    end

    it "should be correct at a non-axial point" do
      sphere = Sphere.new
      point = Point.new(Math.sqrt(3) / 3,Math.sqrt(3) / 3,Math.sqrt(3) / 3)
      expect(sphere.normal_at(intersect: point)).to eq Vector.new(Math.sqrt(3) / 3, Math.sqrt(3) / 3, Math.sqrt(3) / 3)
    end

    context "it should be correct for a translated sphere" do
      it "simple case" do
        sphere = Sphere.new.translate(x: 1, y: 0, z: 0)
        point = Point.new(0, 0, 0)
        expect(sphere.normal_at(intersect: point)).to eq Vector.new(-1, 0, 0)
      end
    end

    it "should be the same for a sphere scaled by 2 in each dimension" do
      sphere = Sphere.new.scale(x: 2, y: 2, z: 2)
      point = Point.new(0,-2,0)
      expect(sphere.normal_at(intersect: point)).to eq Vector.new(0, -1, 0)
    end
  end
end
