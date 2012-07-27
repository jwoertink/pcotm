class MonsterSelectScreen
  attr_reader :window
  
  def initialize(window)
    @window = window
    @monsters = []
    @colors = [:blue, :green, :yellow]
    x = ((window.width / @colors.length) - 50) / 2.0
    @selector = OptionSelector.new(window, x, 240, :value => @colors.length, :arrow => '^')
    @colors.each do |color|
      @monsters << Monster.new(window, x, (window.height / 2), color)
      x += (window.width / @colors.length)
    end
    @select_song = Gosu::Song.new(window, asset_path('select-screen.ogg'))
    @select_song.play(true)
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