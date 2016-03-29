class RemovePartitionIdFromCourse < ActiveRecord::Migration
  def change
  	remove_column :courses, :partition_id
  	remove_column :shards, :partition_id
  end
end
