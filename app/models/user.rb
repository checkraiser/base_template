class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable
  enum role: [:guest, :admin]

  def as_json(options = { })
    h = super(options)

    h[:is_signed_in] = is_signed_in?
    h[:is_admin] = is_admin?
    h[:is_guest] = is_guest?
    return h
  end

  def is_admin?
    admin?
  end

  def is_signed_in?
    id.present?
  end

  def is_guest?
    guest?
  end
end
