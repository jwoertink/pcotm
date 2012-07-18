class Map
  attr_reader :width, :height, :phones
  
  def initialize(window, filename)
    # Load 60x60 tiles, 5px overlap in all four directions.
    @tileset = Gosu::Image.load_tiles(window, "assets/land-tiles.png", 60, 60, true)

    @phones = []

    lines = File.readlines(filename).map { |line| line.chomp }
    @height = lines.size
    @width = lines[0].size
    @tiles = Array.new(@width) do |x|
      Array.new(@height) do |y|
        case lines[y][x, 1]
        when '"'
          Tiles::GRASS
        when '#'
          Tiles::EARTH
        when 'x'
          phone_img = Gosu::Image.new(window, "assets/phone_#{rand(5) + 1}.png", false)
          @phones << Phone.new(phone_img, x * 50 + 25, y * 50 + 25)
          nil
        else
          nil
        end
      end
    end
  end
  
  def draw
    # Very primitive drawing function:
    # Draws all the tiles, some off-screen, some on-screen.
    @height.times do |y|
      @width.times do |x|
        tile = @tiles[x][y]
        if tile
          # Draw the tile with an offset (tile images have some overlap)
          # Scrolling is implemented here just as in the game objects.
          @tileset[tile].draw(x * 50 - 5, y * 50 - 5, 0)
        end
      end
    end
    @phones.each { |c| c.draw }
  end
  
  # Solid at a given pixel position?
  def solid?(x, y)
    y < 0 || @tiles[x / 50][y / 50]
  end
end