class Phone
  attr_reader :x, :y
  
  def initialize(image, x, y)
    @image, @x, @y = image, x, y
  end
  
  def draw
    @image.draw_rot(@x, @y, 0, 25 * Math.sin(Gosu.milliseconds / 133.7))
  end
end