class Parcel < ActiveRecord::Base
  validates_presence_of :name, :unless => Proc.new{ new_record? }

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

  def self.get_all_by_states(*status_ids)
    data = Downloader::Transmission.get_all_states
    data = JSON.parse(data)["arguments"]["torrents"].map{|t| t["hashString"] if status_ids.include? t["status"].to_i}.compact

    where('torrent_id IN (?)', data)
  end

  def self.downloading
    get_all_by_states 1,2,3,4
  end

  def self.seeding
    get_all_by_states 5,6
  end

  def self.paused
    get_all_by_states 0
  end

  private
    before_create :create_torrent

    def create_torrent
      self.torrent_id = Downloader::Transmission.create(asset.to_file)
      #raise "Not unique" if Parcel.find_by_torrent_id(self.torrent_id)
      self.name = self.state.torrent_name if self.name.blank?
    end

    before_destroy :remove_torrent
    def remove_torrent
      Downloader::Transmission.remove(torrent_id)
    end
end
