module Utilities
  
  ROOT_PATH = File.dirname(__FILE__)
  
  def asset_path(filename)
    folder = case filename.split('.').last
    when /(png|jpg|gif)/
      'images'
    when /(ogg|mp3|wav)/
      'audio'
    when /(txt)/
      'maps'
    end
    File.join(ROOT_PATH, 'assets', folder, filename)
  end
  
end