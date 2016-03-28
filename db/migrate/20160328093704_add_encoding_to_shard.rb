class AddEncodingToShard < ActiveRecord::Migration
  def change
    add_column :shards, :encoding, :string
  end
end
