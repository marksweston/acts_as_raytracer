RSpec.describe Ray do
  describe "Rays can be transformed" do
    it "translates the origin but not the direction" do
      ray = Ray.new(origin: Point.new(1 ,2 ,3), direction: Vector.new(0, 1, 0))
      translation = Transform::Translation.new(x: 1, y: 2, z: 3)
      new_ray = ray.transform(matrix: translation)
      expect(new_ray.origin).to eq Point.new(2 ,4 ,6)
      expect(new_ray.direction).to eq Vector.new(0, 1, 0)
    end

    it "scales both origin and direction" do
      ray = Ray.new(origin: Point.new(1 ,2 ,3), direction: Vector.new(0, 1, 0))
      translation = Transform::Scaling.new(x: 1, y: 2, z: 3)
      new_ray = ray.transform(matrix: translation)
      expect(new_ray.origin).to eq Point.new(1 ,4 ,9)
      expect(new_ray.direction).to eq Vector.new(0, 2, 0)
    end
  end

  describe "A ray will #trace its path through a collection of objects and return a collection of intersections" do
    let(:ray) { Ray.new(origin: Point.new(0, 0, 0), direction: Vector.new(0, -1, 0)) }

    it "returns an empty collection when there are no objects passed to it" do
      expect(ray.trace(objects: [])).to eq []
    end

    it "returns an empty collection when it doesn't intersect an object in the collection" do
      objects = [
          Sphere.new.translate(x: 10, y: 0, z: 0)
      ]
      expect(ray.trace objects: objects).to eq []
    end

    it "returns a collection of 2 Intersections when it intersects a sphere in two locations" do
      objects = [
          Sphere.new.translate(x: 0, y: -10, z: 0)
      ]
      expect(ray.trace(objects: objects).count).to eq 2
      expect(ray.trace(objects: objects).first).to be_an Intersection
    end

    it "returns the collection ordered by t (ascending)" do
      objects = [
          Sphere.new.translate(x: 0, y: -10, z: 0),
          Sphere.new.translate(x: 0, y: -5, z: 0)
      ]
      intersections = ray.trace(objects: objects)
      expect(intersections.map{|int| int.t}).to eq [4, 6, 9, 11]
    end

    it "doesn't (for the moment) return intersections with negative t-values (behind the origin)" do
      objects = [
          Sphere.new.translate(x: 0, y: -10, z: 0),
          Sphere.new.translate(x: 0, y: 10, z: 0),
          Sphere.new.translate(x: 0, y: -5, z: 0)
      ]
      intersections = ray.trace(objects: objects)
      expect(intersections.map{|int| int.t}).to eq [4, 6, 9, 11]
    end
  end
end
