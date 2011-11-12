class Parcel < ActiveRecord::Base
  validates_presence_of :name

  attr_readonly :asset, :asset_file_name, :asset_content_type, :asset_file_size, :asset_updated_at
  has_attached_file :asset
  validates_attachment_content_type :asset, :content_type => ["application/x-bittorrent"]
  validates_attachment_presence :asset
  validates_attachment_size :asset, :less_than => 100.kilobytes

end
