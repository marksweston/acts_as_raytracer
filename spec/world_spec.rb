RSpec.describe World do
  describe "it #illuminates every ray hit" do
    # a white plane perpendicular to the eye direction with the light directly behind the eye.
    let(:plane_material) { Material.new(ambient: 0.1, diffuse_reflection: 0.9, specular_reflection: 0.9, shininess: 100) }
    let(:plane) { Plane.new(colour: Colour.new(red: 1, green: 1, blue: 1), material: plane_material) }
    let(:world) do World.new(
      objects: [ plane.rotate(axis: :x, angle: -Math::PI / 2).translate(x: 0, y: 0, z: 1) ],
      light: light)
    end
    context "the camera ray and light ray are both perpendicular to a plane" do
      let(:light) { Light.new(position: Point.new(0 , 0, -2)) }

      it "sets ambient, diffuse and specular reflections to be at full strength" do
        eye = Ray.new(origin: Point.new(0, 0, 0), vector: Vector.new(0, 0, 1))
        hit_colour = world.illuminate(ray: eye, object: plane, intersection_point: Point.new(0, 0, 1))
        full_strength_reflection = plane.colour * plane_material.ambient +
                                   plane.colour * plane_material.diffuse_reflection +
                                   plane.colour * plane_material.specular_reflection
        expect(hit_colour).to eq full_strength_reflection
      end
    end

    context "the light ray is perpendicular to the plane and the camera ray is at 45'" do
      let(:light) { Light.new(position: Point.new(0 , 0, -2)) }
      it "sets ambient and and diffuse reflections to full strength but specular reflection strength is zero" do
        eye = Ray.new(origin: Point.new(-1, 0, 0), vector: Vector.new(1, 0, 1).normalise)
        hit_colour = world.illuminate(ray: eye, object: plane, intersection_point: Point.new(0, 0, 1))
        reflection = plane.colour * plane_material.ambient +
                     plane.colour * plane_material.diffuse_reflection +
                     plane.colour * 0
        expect(hit_colour).to eq reflection
      end
    end

    context "the light ray is at 45' and the camera ray is perpendicular" do
      let(:light) { Light.new(position: Point.new(-3 , 0, -2)) }
      it "ambient reflection is the same, diffuse_reflection is reduced to the dot_product of the light vector and
          the plane's normal, and the specular reflection is zero" do
        eye = Ray.new(origin: Point.new(0, 0, 0), vector: Vector.new(0, 0, 1))
        hit_colour = world.illuminate(ray: eye, object: plane, intersection_point: Point.new(0, 0, 1))
        reflection = plane.colour * plane_material.ambient +
                     plane.colour * plane_material.diffuse_reflection * (Math.sqrt(2) / 2) +
                     plane.colour * 0
        expect(hit_colour).to eq reflection
      end
    end

    context "the light ray is at 45' and the camera ray is at 45' from the normal and 90' from the light" do
      let(:light) { Light.new(position: Point.new(-3 , 0, -2)) }
      it "ambient reflection is the same, diffuse_reflection is reduced to the dot_product of the light vector and
          the plane's normal, and the specular reflection is at maximum because the reflection of the light directly
          hits the eye" do
        eye = Ray.new(origin: Point.new(1, 0, 0), vector: Vector.new(-1, 0, 1).normalise)
        hit_colour = world.illuminate(ray: eye, object: plane, intersection_point: Point.new(0, 0, 1))
        reflection = plane.colour * plane_material.ambient +
                     plane.colour * plane_material.diffuse_reflection * (Math.sqrt(2) / 2) +
                     plane.colour * plane_material.specular_reflection
        expect(hit_colour).to eq reflection
      end
    end

    context "the light on the other side of the plane from the camera ray" do
      let(:light) { Light.new(position: Point.new(0 , 0, 2)) }
      it "ambient reflection is the same, but there is zero diffuse or specular reflection" do
        eye = Ray.new(origin: Point.new(0, 0, 0), vector: Vector.new(0, 0, 1))
        hit_colour = world.illuminate(ray: eye, object: plane, intersection_point: Point.new(0, 0, 1))
        ambient_only_reflection = plane.colour * plane_material.ambient +
                                  plane.colour * 0 +
                                  plane.colour * 0
        expect(hit_colour).to eq ambient_only_reflection
      end
    end
  end
end
