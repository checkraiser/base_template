class AddShardIdToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :shard_id, :integer
    add_index :courses, :shard_id
  end
end
