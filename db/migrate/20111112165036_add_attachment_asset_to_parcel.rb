class AddAttachmentAssetToParcel < ActiveRecord::Migration
  def self.up
    add_column :parcels, :asset_file_name, :string
    add_column :parcels, :asset_content_type, :string
    add_column :parcels, :asset_file_size, :integer
    add_column :parcels, :asset_updated_at, :datetime
  end

  def self.down
    remove_column :parcels, :asset_file_name
    remove_column :parcels, :asset_content_type
    remove_column :parcels, :asset_file_size
    remove_column :parcels, :asset_updated_at
  end
end
