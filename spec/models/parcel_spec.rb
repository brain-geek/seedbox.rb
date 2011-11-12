require 'spec_helper'

describe Parcel do
  before :all do
    @parcel = Factory :parcel
  end

  describe :start do
    pending 'should successfully start the torrent' do
      @parcel.start
      [1,2,3,4].should_include @parcel.torrent.state.to_i
    end
  end

  describe :stop do
    pending 'should successfully stop the torrent' do
      @parcel.stop
      @parcel.torrent.state.to_i.should == 0
    end
  end

  describe :create do
    pending 'should be created on saving' do
      parcel = Factory.build :parcel
      parcel.torrent.should be_nil

      parcel.save!
      parcel.torrent.should_not be_nil

      [1,2,3,4].should_include parcel.torrent.state.to_i
    end
  end

  describe :delete do
    pending 'should preserve parcel but delete the torrent' do
      parcel = Factory :parcel

      parcel.torrent.should_not be_nil
      parcel.delete
      parcel.torrent.should be_nil
    end
  end

end
