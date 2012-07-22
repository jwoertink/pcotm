class Window < Gosu::Window
  attr_reader :map, :game_song
  attr_accessor :game_in_progress, :current_screen, :current_level
  
  def initialize
    super 640, 480, false
    self.caption = "Phone Case of the Monster"
    self.current_level = 1
    self.current_screen = TitleScreen.new(self)
    @timer = Timer.new(self)
    @sky = Gosu::Image.new(self, File.join(File.dirname(__FILE__), 'assets', 'background.png'), true)
    @map = Map.new(self, current_level)
    @monster = Monster.new(self, 400, 100)
    @camera_x = @camera_y = 0
    @score_font = Gosu::Font.new(self, Gosu.default_font_name, 26)
    @game_in_progress = false
    
    @game_song = Gosu::Song.new(self, File.join(File.dirname(__FILE__), 'assets', 'game-song.ogg'))
  end
  
  def update
    if @game_in_progress
      @timer.update
      move_x = 0
      move_x -= 5 if button_down? Gosu::KbLeft
      move_x += 5 if button_down? Gosu::KbRight
      @monster.update(move_x)
      @monster.collect_phones(@map.phones)
      if @monster.level_phone_count >= @map.total_phones
        # Add callback for finding all the phones
        # draw loading screen
        load_new_level
      end
      @camera_x = [[@monster.x - 320, 0].max, @map.width * 50 - 640].min
      @camera_y = [[@monster.y - 240, 0].max, @map.height * 50 - 480].min
    else
      current_screen.update
    end
  end
  
  def draw
    if @game_in_progress
      @sky.draw(0, 0, 0)
      translate -@camera_x, -@camera_y do
        @map.draw
        @monster.draw
      end
      translate 10, 10 do
        score_text = "Phones Collected: #{@monster.phones}"
        score_width = @score_font.text_width(score_text)
        draw_quad 0, 0, 0xaa000000,
                  score_width, 0, 0xaa000000,
                  0, @score_font.height, 0xaa000000,
                  score_width, @score_font.height, 0xaa000000
        @score_font.draw(score_text, 0, 0, 3, 1.0, 1.0, 0xffffffff)
        @timer.print(300, 0)
      end
    else
      current_screen.draw
    end
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
    if @game_in_progress
      game_keys(id)
    else
      current_screen.keys(id)
    end
  end
  
  def game_keys(id)
    @monster.try_to_jump if id == Gosu::KbSpace || id == Gosu::KbUp
  end
  
  def goto(screen)
    self.current_screen = screen
  end
  
  def load_new_level
    self.game_in_progress = false
    self.current_level += 1
    @map = Map.new(self, current_level)
    @timer.reset!
    self.current_screen = ScoreScreen.new(self, @timer)
    self.game_song.stop
    @monster.level_phone_count = 0
    @camera_x = @camera_y = 0
    @monster.x = 100
    @monster.y = 50
  end
  
  def start_new_level
    self.game_in_progress = true
    self.game_song.play(true)
  end
  
end