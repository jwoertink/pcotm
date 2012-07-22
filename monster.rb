class Monster
  attr_reader :phones
  attr_accessor :level_phone_count, :x, :y
  
  def initialize(window, x, y)
    @x, @y = x, y
    @dir = :left
    @vy = 0
    @map = window.map
    @standing, @walk1, @walk2, @jump = *Gosu::Image.load_tiles(window, File.join(File.dirname(__FILE__), 'assets', 'monster.png'), 50, 50, false)
    @cur_image = @standing
    @phones = 0
    self.level_phone_count = 0
    @beep = Gosu::Sample.new(window, File.join(File.dirname(__FILE__), 'assets', 'beep.wav'))
  end
  
  def draw
    if @dir == :left
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
    end
    @cur_image.draw(@x + offs_x, @y - 49, 0, factor, 1.0)
  end
  
  def would_fit?(offs_x, offs_y)
    not @map.solid?(@x + offs_x, @y + offs_y) and not @map.solid?(@x + offs_x, @y + offs_y - 45)
  end
  
  def update(move_x)
    if move_x.zero? 
      @cur_image = @standing 
    else 
      @cur_image = (Gosu.milliseconds / 175 % 2) ? @walk1 : @walk2
    end
    if @vy < 0
      @cur_image = @jump
    end
    
    if move_x > 0
      @dir = :right
      move_x.times { @x += 1 if would_fit?(1, 0) }
    end
    if move_x < 0
      @dir = :left
      (-move_x).times { @x -= 1 if would_fit?(-1, 0) }
    end
    
    @vy += 1
    if @vy > 0
      @vy.times { would_fit?(0, 1) ? @y += 1 : @vy = 0 }
    end
    if @vy < 0
      (-@vy).times { would_fit?(0, -1) ? @y -= 1 : @vy = 0 }
    end
  end
  
  def try_to_jump
    @vy = -20 if @map.solid?(@x, @y + 1)
  end
  
  def collect_phones(phones)
    phones.reject! do |phone|
      if (phone.x - @x).abs < 50 and (phone.y - @y).abs < 50
        @phones += 1
        self.level_phone_count += 1
        @beep.play
        true
      end
    end
  end
end