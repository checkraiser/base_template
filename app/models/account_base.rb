class AccountBase < ActiveRecord::Base
  self.abstract_class = true

  def self.activate_shard subdomain
  	account = Account.find_by subdomain: subdomain
  	if account
  	  self.establish_connection account.shard.to_config 
      Account.current_id = account.id
  	  return account
  	else
  	  self.establish_connection Rails.env
      return nil
    end
  end
end