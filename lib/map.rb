class Map
  attr_accessor :width, :height, :phones, :tiles
  
  def initialize(window, level)
    filename = asset_path("level_#{level}.txt")
    # Load 60x60 tiles, 5px overlap in all four directions.
    @tileset = Gosu::Image.load_tiles(window, asset_path('land-tiles.png'), 60, 60, true)

    self.phones = []

    lines = File.readlines(filename).map { |line| line.chomp }
    self.height = lines.size
    self.width = lines[0].size
    self.tiles = Array.new(width) do |x|
      Array.new(height) do |y|
        case lines[y][x, 1]
        when '"'
          Tiles::GRASS
        when '#'
          Tiles::EARTH
        when 'x'
          phone_img = Gosu::Image.new(window, asset_path("phone_#{rand(14) + 1}.png"), false)
          self.phones << Phone.new(phone_img, x * 50 + 25, y * 50 + 25)
          nil
        else
          nil
        end
      end
    end
    @total = phones.length
  end
  
  def draw
    height.times do |y|
      width.times do |x|
        tile = tiles[x][y]
        @tileset[tile].draw(x * 50 - 5, y * 50 - 5, 0) unless tile.nil?
      end
    end
    phones.map(&:draw)
  end
  
  def solid?(x, y)
    y < 0 || tiles[x / 50][y / 50]
  end
  
  def total_phones
    @total
  end
end