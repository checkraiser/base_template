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
            shard.accounts.create! email: "#{dbname}@example.com", password: "12345678", password_confirmation: "12345678", subdomain: dbname
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

end
