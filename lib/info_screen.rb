class InfoScreen
  attr_reader :window
  
  def initialize(window)
    @window = window
    @help_text = Gosu::Font.new(window, Gosu.default_font_name, 42)
    @background = Gosu::Image.new(window, asset_path('info-bg.jpg'), true)
  end
  
  def draw_background
    # @window.draw_quad(
    #   0, 0, 0xFFFED659,
    #   @window.width, 0, 0xFFFED659,
    #   0, @window.height, 0xFFFEE7A8,
    #   @window.width, @window.height, 0xFFFEE7A8
    # )
    @background.draw(0, 0, 0)
  end
  
  def draw
    draw_background
    h1 = "ABOUT #PCOTM"
    help_text_width = @help_text.text_width(h1)
    @help_text.draw(h1, (@window.width / 2) - (help_text_width / 2) , 60, 5, 1.0, 1.0, 0xFFBF202F)
  end
  
  def update
    
  end
  
  def keys(id)
    @window.goto(TitleScreen.new(@window))
  end
  
end