class Window < Gosu::Window
  attr_reader :game_song
  attr_accessor :map, :game_in_progress, :current_screen, :current_level, :monster, :timer, :cursor_active, :phones_to_collect
  
  def initialize
    super 640, 480, false
    @caption = "Phone Case of the Monster"
    @current_level = 1
    @current_screen = TitleScreen.new(self)
    @cursor_active = false
    @map = Map.new(self, current_level)
    @timer = Timer.new(self)
    @sky = Gosu::Image.new(self, asset_path('background.png'), true)
    @camera_x = @camera_y = 0
    @score_font = Gosu::Font.new(self, Gosu.default_font_name, 26)
    @game_in_progress = false
    @phones_to_collect = map.total_phones
    @game_song = Gosu::Song.new(self, asset_path('game-song.ogg'))
  end
  
  def update
    if @game_in_progress
      move_x = 0
      move_x -= 5 if button_down? Gosu::KbLeft
      move_x += 5 if button_down? Gosu::KbRight
      @monster.update(move_x)
      @monster.collect_phones(map.phones)
      if @monster.level_phone_count >= map.total_phones
        if current_level == 3
          load_end_game
        else
          load_new_level
        end
      end
      @camera_x = [[@monster.x - 320, 0].max, map.width * 50 - 640].min
      @camera_y = [[@monster.y - 240, 0].max, map.height * 50 - 480].min
      @timer.update
    else
      current_screen.update
    end
  end
  
  def draw
    if @game_in_progress
      @sky.draw(0, 0, 0)
      translate -@camera_x, -@camera_y do
        map.draw
        @monster.draw
      end
      translate 10, 10 do
        score_text = "Phones Collected: #{@monster.phones} / #{@phones_to_collect}"
        score_width = @score_font.text_width(score_text)
        draw_quad 0, 0, 0xaa000000,
                  score_width, 0, 0xaa000000,
                  0, @score_font.height, 0xaa000000,
                  score_width, @score_font.height, 0xaa000000
        @score_font.draw(score_text, 0, 0, 3, 1.0, 1.0, 0xffffffff)
        @timer.draw(300, 0)
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
    @current_screen = screen
  end
  
  def load_new_level
    @game_in_progress = false
    @current_level += 1
    @map = Map.new(self, current_level)
    @monster.map = map
    @timer.reset!
    @current_screen = ScoreScreen.new(self, @timer)
    @game_song.stop
    @monster.level_phone_count = 0
    @camera_x = @camera_y = 0
    @monster.x = 100
    @monster.y = 50
    @phones_to_collect = @map.total_phones + @monster.level_phone_count
  end
  
  def start_new_level
    @game_in_progress = true
    @game_song.play(true)
    @timer = Timer.new(self)
  end
  
  def load_end_game
    @game_in_progress = false
    @current_screen = EndGameScreen.new(self)
    @game_song.stop
    current_screen.end_song.play(true)
  end
  
  def needs_cursor?
    @cursor_active
  end
  
end