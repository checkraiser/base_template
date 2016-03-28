class AddPoolToShard < ActiveRecord::Migration
  def change
    add_column :shards, :pool, :integer
  end
end
