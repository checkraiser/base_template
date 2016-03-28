class AddStatusToShard < ActiveRecord::Migration
  def change
    add_column :shards, :status, :integer
  end
end
