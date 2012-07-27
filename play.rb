require 'rubygems'
require 'gosu'
require File.join(File.dirname(__FILE__), 'timer')
require File.join(File.dirname(__FILE__), 'tiles')
require File.join(File.dirname(__FILE__), 'window')
require File.join(File.dirname(__FILE__), 'monster')
require File.join(File.dirname(__FILE__), 'map')
require File.join(File.dirname(__FILE__), 'phone')
require File.join(File.dirname(__FILE__), 'option_selector')
require File.join(File.dirname(__FILE__), 'title_screen')
require File.join(File.dirname(__FILE__), 'info_screen')
require File.join(File.dirname(__FILE__), 'score_screen')
require File.join(File.dirname(__FILE__), 'monster_select_screen')
require File.join(File.dirname(__FILE__), 'utilities')
include Utilities

window = Window.new
window.show