require 'rubygems'
require 'gosu'
$: << File.join(File.dirname(__FILE__), 'lib')
require 'utilities'
include Utilities

require 'timer'
require 'tiles'
require 'window'
require 'monster'
require 'map'
require 'phone'
require 'option_selector'
require 'title_screen'
require 'info_screen'
require 'score_screen'
require 'monster_select_screen'
require 'end_game_screen'


Window.new.show