class CreateShards < ActiveRecord::Migration
  def change
    create_table :shards do |t|
      t.string :database
      t.string :host
      t.string :adapter
      t.string :username
      t.string :password
      t.string :port

      t.timestamps null: false
    end
  end
end
