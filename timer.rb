class Timer
  attr_reader :hours, :minutes, :seconds

  def initialize(window)
    @hours = 0
    @minutes = 0
    @seconds = 0
    @last_time = Gosu.milliseconds
    @font = Gosu::Font.new(window, Gosu.default_font_name, 26)
  end

  def update
    if (Gosu.milliseconds - @last_time) / 1000 == 1
      @last_time = Gosu.milliseconds
      @seconds += 1
    end
    if @seconds > 59
      @seconds = 0
      @minutes += 1
    end
    if @minutes > 59
      @minutes = 0
      @hours += 1
    end
  end
  
  def print(x, y)
    @font.draw("Elapsed Time: #{@hours}:#{@minutes}:#{@seconds}",x, y, 3, 1.0, 1.0, 0xff6F0000)
  end
  
  def reset!
    @hours = @minutes = @seconds = 0
    @last_time = Gosu.milliseconds
  end
  
end