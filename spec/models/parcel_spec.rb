require 'spec_helper'

describe Parcel do
  [:asset, :asset_file_name, :asset_content_type, :asset_file_size, :asset_updated_at].each do |a|
    it { should have_readonly_attribute a}
  end

  it { should have_readonly_attribute :torrent_id }

  it { should validate_attachment_presence(:asset) }
  it { should validate_attachment_content_type(:asset).
                allowing('application/x-bittorrent').
                rejecting('text/plain', 'text/xml', 'image/png', 'image/gif') }
  it { should validate_attachment_size(:asset).less_than(100.kilobytes) }

  before :all do
    @parcel = Factory :parcel
  end

  after :all do
    # clean up
    Downloader::Transmission.remove 'c48de387a47667d741b6e5845163167f893f91aa'
  end

  describe :start do
    it 'should successfully start the torrent' do
      @parcel.start
      sleep 1
      [1,2,3,4].include?(@parcel.state.status.to_i).should == true
    end
  end

  describe :stop do
    it 'should successfully stop the torrent' do
      @parcel.stop
      sleep 1
      @parcel.state.status.to_i.should == 0
    end
  end

  describe :state do
    it "should raise if no torrents found" do
      parcel = Factory.build :parcel, :torrent_id => 'non-existent!'
      lambda { parcel.state }.should raise_error

      parcel = Factory :parcel
      parcel.torrent_id = 'non-existent!'
      lambda { parcel.state }.should raise_error
    end
  end

  describe :create do
    it 'should be created on saving' do
      parcel = Factory.build :parcel
      parcel.save!
      parcel.torrent_id.should == 'c48de387a47667d741b6e5845163167f893f91aa'
    end
  end

  describe :name do
    it "should get name from torrent, if 'name' is blank" do
      parcel = Factory :parcel, :name => ''
      parcel.name.should == 'debian-6.0.3-i386-businesscard.iso'
    end
    
    it "should not allow setting name to blank after creation" do
      parcel = Factory :parcel
      parcel.valid?.should be_true
      parcel.name = ''
      parcel.valid?.should be_false
    end
  end

  describe :delete do
    it 'Resque task should delete torrents with no matching parcels' do
      parcel = Factory :parcel

      parcel.state.should_not be_nil

      p = Parcel.find(parcel.id)
      p.destroy

      lambda { parcel.state }.should raise_error
    end
  end
end
