class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  # twitter login↓↓↓↓↓↓
  protect_from_forgery with: :exception

  helper_method :current_user_tw, :logged_in_tw?

  private

  def current_user_tw
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in_tw?
    !!session[:user_id]
  end

  def authenticate
    return if logged_in_tw?
    flash[:danger] = 'ログインしてください'
    redirect_to root_path
  end
  # twitter login↑↑↑↑↑

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  private

  def read(result)
    code = result.code
    name = result['itemName']
    url = result.url
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')

    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
end
