# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'factory_girl_rails'
Factory :parcel, :asset => File.new(Rails.root.join('spec', 'fixtures', 'debian-6.0.3-i386-businesscard.iso.torrent'))