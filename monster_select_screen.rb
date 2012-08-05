class MonsterSelectScreen
  attr_reader :window
  
  def initialize(window)
    @window = window
    @background = Gosu::Image.new(window, asset_path('monster-select-bg.jpg'), true)
    @monsters = []
    @colors = [:blue, :green, :yellow]
    x = ((window.width / @colors.length) - 50) / 2.0
    @selector = OptionSelector.new(window, x - 20, 270, :value => @colors.length, :arrow => "down")
    @colors.each do |color|
      @monsters << Monster.new(window, x, 400, color)
      x += (window.width / @colors.length)
    end
    @select_song = Gosu::Song.new(window, asset_path('select-screen.ogg'))
    @select_song.play(true)
  end
  
  def draw_background
    @background.draw(0, 0, 0)
  end
  
  def draw
    draw_background
    @monsters.map(&:draw)
    @selector.draw
  end
  
  def update
    
  end
  
  def keys(id)
    case id
    when Gosu::KbLeft
      @selector.move_left
    when Gosu::KbRight
      @selector.move_right
    when Gosu::KbReturn
      @select_song.stop
      @window.monster = Monster.new(@window, 400, 100, @colors[@selector.value - 1])
      @window.game_in_progress = true
      @window.game_song.play(true)
    end
  end
  
end