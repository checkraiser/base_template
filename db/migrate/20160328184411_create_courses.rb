class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :account_id
      t.references :shard, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
