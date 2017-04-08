module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def link?(provider=null)
    @link = Link.find_by(user_id: session[:user_id], provider: provider)
    return !!@link
  end
end