class AddPartitionIdToShard < ActiveRecord::Migration
  def change
    add_column :shards, :partition_id, :integer
  end
end
