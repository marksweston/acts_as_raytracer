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
end
