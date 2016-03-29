class AddAncestryToShard < ActiveRecord::Migration
  def change
    add_column :shards, :ancestry, :string
    add_index :shards, :ancestry
  end
end
