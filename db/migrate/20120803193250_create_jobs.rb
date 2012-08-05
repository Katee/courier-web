class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :client
      t.string :notes

      t.timestamps
    end
  end
end
