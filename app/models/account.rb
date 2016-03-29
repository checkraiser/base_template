class Account < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :shard, counter_cache: :count_of_accounts
  has_many :courses
  cattr_accessor :current_id
  
end
