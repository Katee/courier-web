class CreateDrops < ActiveRecord::Migration
  def change
    create_table :drops do |t|
      t.datetime :authorized_on
      t.string :authorized_by
      t.references :job
      t.references :location

      t.timestamps
    end
  end
end
