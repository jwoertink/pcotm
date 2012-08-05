require 'rubygems'
require 'gosu'
require_relative 'utilities'
include Utilities

require lib_path('timer')
require lib_path('tiles')
require lib_path('window')
require lib_path('monster')
require lib_path('map')
require lib_path('phone')
require lib_path('option_selector')
require lib_path('title_screen')
require lib_path('info_screen')
require lib_path('score_screen')
require lib_path('monster_select_screen')
require lib_path('end_game_screen')


window = Window.new
window.show