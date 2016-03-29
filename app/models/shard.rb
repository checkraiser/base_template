class Shard < ActiveRecord::Base
  has_ancestry
  has_many :accounts
  has_many :courses
  enum status: [:created, :migrated, :used]

  def to_config
  	{'database' => database,
  	 'adapter' => adapter,
  	 'host' => host,
  	 'username' => username,
  	 'password' => password,
  	 'pool' => pool,
  	 'encoding' => encoding}
  end
end
