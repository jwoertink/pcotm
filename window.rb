class Window < Gosu::Window
  attr_reader :map
  
  def initialize
    super 640, 480, false
    self.caption = "PCOTM Monster Phone"
    @sky = Gosu::Image.new(self, "assets/background.png", true)
    @map = Map.new(self, "assets/map.txt")
    @monster = Monster.new(self, 400, 100)
    @camera_x = @camera_y = 0
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)
  end
  
  def update
    move_x = 0
    move_x -= 5 if button_down? Gosu::KbLeft
    move_x += 5 if button_down? Gosu::KbRight
    @monster.update(move_x)
    @monster.collect_phones(@map.phones)
    @camera_x = [[@monster.x - 320, 0].max, @map.width * 50 - 640].min
    @camera_y = [[@monster.y - 240, 0].max, @map.height * 50 - 480].min
  end
  
  def draw
    @sky.draw(0, 0, 0)
    translate(-@camera_x, -@camera_y) do
      @map.draw
      @monster.draw
      @font.draw("Phones Collected: #{@monster.phones}", @camera_x + 10, @camera_y + 10, 3, 1.0, 1.0, 0xff8F2121)
    end
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
    @monster.try_to_jump if id == Gosu::KbUp
  end
  
end