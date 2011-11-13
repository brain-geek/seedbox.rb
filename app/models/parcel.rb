class Parcel < ActiveRecord::Base
  validates_presence_of :name

  attr_readonly :torrent_id

  attr_readonly :asset, :asset_file_name, :asset_content_type, :asset_file_size, :asset_updated_at
  has_attached_file :asset
  validates_attachment_content_type :asset, :content_type => ["application/x-bittorrent"]
  validates_attachment_presence :asset
  validates_attachment_size :asset, :less_than => 100.kilobytes

  def state
    Downloader::Transmission.state(torrent_id)
  end

  def stop
    Downloader::Transmission.stop(torrent_id)
  end

  def start
    Downloader::Transmission.start(torrent_id)
  end

  private
    before_create :create_torrent

    def create_torrent
      self.torrent_id = Downloader::Transmission.create(asset.to_file) if self.new_record?
      #raise "Not unique" if Parcel.find_by_torrent_id(self.torrent_id)
    end

    before_destroy :remove_torrent
    def remove_torrent
      Downloader::Transmission.remove(torrent_id)
    end
end
