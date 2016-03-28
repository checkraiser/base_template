class AddShardToAccount < ActiveRecord::Migration
  def change
    add_reference :accounts, :shard, index: true, foreign_key: true
  end
end
