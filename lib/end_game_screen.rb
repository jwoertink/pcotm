class EndGameScreen
  attr_reader :end_song
  
  def initialize(window)
    @window = window
    @window.cursor_active = true
    @text = Gosu::Font.new(window, Gosu.default_font_name, 30)
    @code = "X2D5A3Q"
    @end_song = Gosu::Song.new(window, asset_path('end-game.ogg'))
    tweet_text = "I%20just%20played%20and%20beat%20%23PCOTM%20http%3A%2F%2Fbit.ly%2FMbZUMo%20%40PhoneCaseOfTheM"
    @tweet_url = "https://twitter.com/intent/tweet?#{tweet_text}"
    @pcotm_url = "https://www.phonecaseofthemonth.com/account/new"
  end
  
  def draw
    @text.draw("CONGRATS!", 100, 80, 3, 1.0, 1.0, 0xff086279)
    @text.draw("You completed PCOTM.", 100, 120, 3, 1.0, 1.0, 0xff086279)
    @text.draw("Sign up for phonecaseofthemonth.com", 100, 160, 3, 1.0, 1.0, 0xff086279)
    @text.draw("and enter #{@code} for a free case!", 100, 190, 3, 1.0, 1.0, 0xff086279)
    @text.draw("press enter to get started esc to quit", 100, 350, 3, 1.0, 1.0, 0xff086279)
  end
  
  def update
    
  end
  
  def keys(id)
    if id == Gosu::KbReturn
      `open #{@pcotm_url}`
    end
  end
  
end