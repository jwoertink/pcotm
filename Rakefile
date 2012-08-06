require 'rubygems'
require 'bundler/setup'
require 'releasy'

Releasy::Project.new do
  name "PCOTM"
  version "1.0.0"

  executable "lib/play.rb"
  files ["lib/*.rb", "assets/**/*.*"]
  exposed_files ["README.rdoc", "LICENSE.txt"]
  add_link "https://www.phonecaseofthemonth.com", "Phone Case of The Month"
  exclude_encoding

  # Create a variety of releases, for all platforms.
  add_build :osx_app do
    url "com.github.my_application"
    wrapper "vendor/gosu-mac-wrapper-0.7.44.tar.gz" # Assuming this is where you downloaded this file.
    icon "assets/images/icon.icns"
    add_package :dmg
  end

end
