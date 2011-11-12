class CreateParcels < ActiveRecord::Migration
  def change
    create_table :parcels do |t|
      t.string :name
      t.string :torrent_id

      t.timestamps
    end
  end
end
