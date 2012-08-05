class OptionSelector
  attr_reader :x, :y, :value, :options
  
  def initialize(window, x, y, options = {})
    @value = 1
    @options = options[:value] || 1
    @x, @y = x, y
    direction = options[:arrow] || "right"
    @arrow = Gosu::Image.new(window, asset_path("arrow-#{direction}.png"), true)
    @arrow.draw(@x, @y, 3)
  end
  
  def draw
    @arrow.draw(@x, @y, 3)
  end
  
  # Move up to the next option unless the value is 0
  def move_up
    unless @value.eql? 1
      @y -= 50
      @value -= 1
    end
  end
  
  # Move down to the next option unless the value is the last possible option
  def move_down
    if @value < @options
      @y += 50
      @value += 1
    end
  end
  
  
  def move_left
    unless @value.eql? 1
      @x -= 213
      @value -= 1
    end
  end
  
  def move_right
    if @value < @options
      @x += 213
      @value += 1
    end
  end
  
end