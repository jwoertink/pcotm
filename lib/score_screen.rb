class ScoreScreen
  attr_reader :timer
  
  def initialize(window, timer)
    @window = window
    @timer = timer
    @text = Gosu::Font.new(window, Gosu.default_font_name, 30)
  end
  
  def draw
    @window.draw_quad(
      0, 0, 0xffA0ECFF,
      @window.width, 0, 0xffA0ECFF,
      0, @window.height, 0xff69D6F1,
      @window.width, @window.height, 0xff69D6F1
    )
    @text.draw("Level completed in: #{@timer.stopped_time}", 100, 100, 3, 1.0, 1.0, 0xff086279)
    @text.draw("Press enter to continue...", 100, 200, 3, 1.0, 1.0, 0xffaa0000)
  end
  
  def update
    
  end
  
  def keys(id)
    if id == Gosu::KbReturn
      @window.start_new_level
    end
  end
  
end