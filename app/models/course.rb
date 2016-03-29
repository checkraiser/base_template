class Course < AccountBase
  belongs_to :shard, counter_cache: :count_of_courses
  belongs_to :account
  cattr_accessor :current_id
  default_scope { where(account_id: Account.current_id) }
  before_save :set_shard

  protected
  def set_shard
  	self.shard = account.shard.children.order(:count_of_courses).first
  end
end
