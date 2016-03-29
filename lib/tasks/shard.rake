namespace :shard do
  desc "TODO"
  task create: :environment do
    connection = ActiveRecord::Base.connection
  	environments = ['test', 'development', 'production']
  	accounts = [:account1, :account2, :account3]
  	environments.each do |env|
      accounts.each do |account|
        dbname = "#{account}_#{env}"
        shard = Shard.find_by(database: dbname)
        unless shard
          db_conf = YAML::load(File.open(File.join("#{Rails.root}",'config','database.yml')))
          db_conf[env]['username'] = 'postgres'
          db_conf[env]['database'] = dbname
          shard = Shard.create! db_conf[env]
          shard.created!
          shard.accounts.create! email: "#{dbname}@example.com", password: "12345678", password_confirmation: "12345678", subdomain: dbname, partition: 5
          (1..5).each do |i|
            dbname_child = dbname + "_partition_#{i}"
            db_conf[env]['database'] = dbname_child
            shard.children.create! db_conf[env]
          end
        end
      end
  	end
    Shard.all.each do |shard|
      connection.create_database shard.database, shard.to_config
      puts "#{shard.database} created"
    end
  end
  task drop: :environment do
    connection = ActiveRecord::Base.connection
    Account.delete_all
    Shard.all.each do |shard|
      connection.drop_database shard.database
    end
    Shard.delete_all
  end
  task migrate: :environment do
    Shard.all.each do |shard|
      ActiveRecord::Base.establish_connection shard.to_config
      ActiveRecord::Migrator.migrate("db/migrate/")
      shard.migrated!
    end
  end
  task create_courses: :environment do
    Account.all.each do |acc|
      AccountBase.activate_shard acc.id
      (1..100).each do |i|
        course = acc.courses.create! name: "course_#{i}"
        puts course.attributes
      end
    end
  end
end
