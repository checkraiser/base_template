class RemoveShardIdFromCourse < ActiveRecord::Migration
  def change
  	remove_reference :courses, :shard
  end
end
