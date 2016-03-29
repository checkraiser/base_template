class AddCountOfCoursesAndCountOfAccountsToShard < ActiveRecord::Migration
  def change
    add_column :shards, :count_of_courses, :integer, null: false, default: 0
    add_column :shards, :count_of_accounts, :integer, null: false, default: 0
  end
end
