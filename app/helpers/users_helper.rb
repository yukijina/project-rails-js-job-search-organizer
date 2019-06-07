module UsersHelper
  def admin?(user)
    true if user.admin == true
  end
end
