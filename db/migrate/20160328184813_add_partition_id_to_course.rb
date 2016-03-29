class AddPartitionIdToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :partition_id, :integer
  end
end
