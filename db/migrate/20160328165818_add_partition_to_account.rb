class AddPartitionToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :partition, :integer
  end
end
