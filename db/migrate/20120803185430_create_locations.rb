class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :postal
      t.string :city
      t.string :state
      t.string :country
      t.references :client

      t.timestamps
    end
  end
end
