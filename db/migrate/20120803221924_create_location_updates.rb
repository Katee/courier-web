class CreateLocationUpdates < ActiveRecord::Migration
  def change
    create_table :location_updates do |t|
      t.references :courier
      t.decimal :lat
      t.decimal :lng
      t.datetime :at

      t.timestamps
    end
    add_index :location_updates, :courier_id
  end
end
