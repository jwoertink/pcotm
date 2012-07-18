class Window < Gosu::Window
  attr_reader :map, :game_song
  attr_accessor :game_in_progress
  
  def initialize
    super 640, 480, false
    self.caption = "Phone Case of the Monster"
    @sky = Gosu::Image.new(self, File.join(File.dirname(__FILE__), 'assets', 'background.png'), true)
    @map = Map.new(self, "assets/map.txt")
    @monster = Monster.new(self, 400, 100)
    @camera_x = @camera_y = 0
    @score_font = Gosu::Font.new(self, Gosu.default_font_name, 26)
    @game_in_progress = false
    @title_screen = TitleScreen.new(self)
    @game_song = Gosu::Song.new(self, File.join(File.dirname(__FILE__), 'assets', 'game-song.mp3')
  end
  
  def update
    if @game_in_progress
      move_x = 0
      move_x -= 5 if button_down? Gosu::KbLeft
      move_x += 5 if button_down? Gosu::KbRight
      @monster.update(move_x)
      @monster.collect_phones(@map.phones)
      @camera_x = [[@monster.x - 320, 0].max, @map.width * 50 - 640].min
      @camera_y = [[@monster.y - 240, 0].max, @map.height * 50 - 480].min
    else
      @title_screen.update
    end
  end
  
  def draw
    if @game_in_progress
      @sky.draw(0, 0, 0)
      translate(-@camera_x, -@camera_y) do
        @map.draw
        @monster.draw
        @score_font.draw("Phones Collected: #{@monster.phones}", @camera_x + 10, @camera_y + 10, 3, 1.0, 1.0, 0xff8F2121)
      end
    else
      @title_screen.draw
    end
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
    if @game_in_progress
      game_keys(id)
    else
      @title_screen.keys(id)
    end
  end
  
  def game_keys(id)
    @monster.try_to_jump if id == Gosu::KbUp
  end
  
end