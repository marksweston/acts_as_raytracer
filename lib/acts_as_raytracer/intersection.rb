class Intersection
  def initialize(t:, object:)
    @t = t
    @object = object
  end

  attr_reader :t, :object

  def <=>(other)
    return self.t <=> other.t
  end
end
