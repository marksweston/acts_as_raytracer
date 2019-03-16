class Transform
  def transpose
    return @transpose ||= self.class.new_from_matrix(self.transform_matrix.getTransposed)
  end
end
