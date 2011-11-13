# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.sequence(:parcel_id) { |n| n }

FactoryGirl.define do
  factory :parcel do
    name { Faker::Lorem.words(3).join(' ').capitalize}
    asset do
     content = BEncode.load_file(Rails.root.join('spec', 'fixtures', 'debian-6.0.3-i386-businesscard.iso.torrent'))

     #rewrite me!
     content["info"]["name"] = Factory.next(:parcel_id).to_s + '-debian.iso'

     tf = Tempfile.new(['', '.torrent'])

     tf.write content.bencode.force_encoding('utf-8')

     tf
    end
  end
end
