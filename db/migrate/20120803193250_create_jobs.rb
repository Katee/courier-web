class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :notes
      t.references :user
      t.references :client

      t.timestamps
    end
  end
end
