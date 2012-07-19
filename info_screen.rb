class InfoScreen
  attr_reader :window
  
  def initialize(window)
    @window = window
    @help_text = Gosu::Font.new(window, Gosu.default_font_name, 30)
  end
  
  def draw_background
    @window.draw_quad(
      0, 0, Gosu::Color::WHITE,
      @window.width, 0, Gosu::Color::WHITE,
      0, @window.height, Gosu::Color::WHITE,
      @window.width, @window.height, Gosu::Color::WHITE
    )
  end
  
  def draw
    draw_background
    @help_text.draw("About PCOTM: ", 100, 100, 5, 1.0, 1.0, Gosu::Color::BLACK)
  end
  
  def update
    
  end
  
  def keys(id)
    case id
    when Gosu::KbUp
      
    when Gosu::KbDown
      
    when Gosu::KbReturn
      @window.goto(TitleScreen.new(@window))
    end
  end
  
end