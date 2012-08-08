class LocationAddLatLng < ActiveRecord::Migration
  def change
    add_column :locations, :lat, :decimal
    add_column :locations, :lng, :decimal
  end
end
