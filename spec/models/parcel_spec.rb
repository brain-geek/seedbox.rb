require 'spec_helper'

describe Parcel do
  it { should validate_presence_of(:name) }

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

  describe :start do
    it 'should successfully start the torrent' do
      @parcel.start
      sleep 1
      @parcel.state.status.should_not == nil
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
      parcel = Factory.build :parcel, :torrent_id => 'non-existant!'
      lambda { parcel.state }.should raise_error

      parcel = Factory :parcel
      parcel.torrent_id = 'non-existant!'
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

  describe :delete do
    it 'Resque task should delete torrents with no matching parcels' do
      parcel = Factory :parcel

      parcel.state.should_not be_nil
      parcel.remove
      lambda { parcel.state }.should raise_error
    end
  end

end
