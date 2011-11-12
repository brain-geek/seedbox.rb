# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parcel do
    name "Debian 6.0.3 i386"
    asset { File.new(Rails.root.join('spec', 'fixtures', 'debian-6.0.3-i386-businesscard.iso.torrent')) }
  end
end
