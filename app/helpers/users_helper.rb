module UsersHelper
  def gravatar_url(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm"
  end

  def twitter_url(user)
    twitter_img = user.image_url
    "#{twitter_img}"
  end
end