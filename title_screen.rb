class TitleScreen
  attr_reader :window
  
  def initialize(window)
    @window = window
    @background = Gosu::Image.new(window, asset_path('title-screen.png'), true)
    set_text!
    @selector = OptionSelector.new(window, 160, 280, :value => 3)
    @title_song = Gosu::Song.new(window, asset_path('title-screen.ogg'))
    @title_song.play(true)
  end
  
  def draw
    @background.draw(0, 0, 0)
    @selector.draw
    @start_option.draw("Start Game", 180, 280, 5, 1.0, 1.0, Gosu::Color::BLACK)
    @about_option.draw("About PCOTM", 180, 320, 5, 1.0, 1.0, Gosu::Color::BLACK)
    @quit_option.draw("Quit Game", 180, 360, 5, 1.0, 1.0, Gosu::Color::BLACK)
  end
  
  def update
    
  end
  
  def keys(id)
    case id
    when Gosu::KbUp
      @selector.move_up
    when Gosu::KbDown
      @selector.move_down
    when Gosu::KbReturn
      case @selector.value
      when 1
        @title_song.stop
        @monster_select_screen = MonsterSelectScreen.new(@window)
        @window.goto(@monster_select_screen)
      when 2
        @title_song.stop
        @info_screen = InfoScreen.new(@window)
        @window.goto(@info_screen)
      when 3
        @window.close
      end
    end
  end
  
  def set_text!
    @start_option = Gosu::Font.new(@window, Gosu.default_font_name, 32)
    @about_option = Gosu::Font.new(@window, Gosu.default_font_name, 32)
    @quit_option = Gosu::Font.new(@window, Gosu.default_font_name, 32)
  end
  
end