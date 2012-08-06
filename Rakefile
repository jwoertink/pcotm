require 'rubygems'
require 'bundler/setup'
require 'releasy'

Releasy::Project.new do
  #verbose
  name "PCOTM"
  version "1.0.0"

  executable "lib/play.rb"
  files ["lib/*.rb", "assets/**/*.*"]
  exposed_files ["README.rdoc", "LICENSE.txt"]
  add_link "https://www.phonecaseofthemonth.com", "Phone Case of The Month"
  exclude_encoding

  add_build :osx_app do
    url "com.github.my_application"
    wrapper "vendor/gosu-mac-wrapper-0.7.44.tar.gz"
    icon "assets/images/icon.icns"
    add_package :dmg
  end

  add_build :windows_wrapped do
    wrapper "vendor/ruby-1.9.3-p0-i386-mingw32.7z"
    executable_type :windows
    exclude_tcl_tk
    add_package :zip
  end

end
