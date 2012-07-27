class OptionSelector
  attr_reader :x, :y, :value, :options
  
  def initialize(window, x, y, options = {})
    @value = 1
    @options = options[:value] || 1
    @x, @y = x, y
    @arrow = Gosu::Font.new(window, Gosu.default_font_name, 32)
    @arrow_text = options[:arrow] || ">"
    @arrow_color = Gosu::Color::BLACK
    @arrow.draw(@arrow_text, @x, @y, 3, 1.0, 1.0, @arrow_color)
  end
  
  def draw
    @arrow.draw(@arrow_text, @x, @y, 3, 1.0, 1.0, @arrow_color)
  end
  
  # Move up to the next option unless the value is 0
  def move_up
    unless @value.eql? 1
      @y -= 40
      @value -= 1
    end
  end
  
  # Move down to the next option unless the value is the last possible option
  def move_down
    if @value < @options
      @y += 40
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