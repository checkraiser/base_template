module Auth
  def app_user
    if current_user.present?
      return current_user
    end
    return User.new
  end

end