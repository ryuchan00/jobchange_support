class User < ApplicationRecord
  # before_save { self.email.downcase! }
  validates :name, presence: true, length: {maximum: 50}
  # validates :email, presence: true, length: { maximum: 255 },
  #                   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
  #                   uniqueness: { case_sensitive: false }
  # has_secure_password

  has_many :ownerships
  has_many :items, through: :ownerships
  has_many :wants
  has_many :want_items, through: :wants, class_name: 'Item', source: :item
  has_many :haves, class_name: "Have"
  has_many :have_items, through: :haves, class_name: 'Item', source: :item
  has_many :owns
  has_many :own_items, through: :owns, class_name: 'Item', source: :item
  has_many :links, class_name: "Link"

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    logger.debug(auth[:provider])
    uid = auth[:uid]
    logger.debug(auth[:uid])
    nickname = auth[:info][:nickname]
    logger.debug(auth[:info][:nickname])
    image_url = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = nickname
      user.image_url = image_url
    end
  end

  # Link
  def link(user, provider=nil)
    self.links.find_by(user_id: user.id, provider: provider)
  end

  def unlink(link)
    link = self.links.find_by(link_id: link.id)
    link.destroy if link
  end

  # def link?(provider=null)
  #   @user = current_user_tw
  #   @link = @user.links_find_by(user_id: @user.id, provider: provider)
  #   self.links.include?(@link)
  # end

  def want(item)
    self.wants.find_or_create_by(item_id: item.id)
  end

  def unwant(item)
    want = self.wants.find_by(item_id: item.id)
    want.destroy if want
  end

  def want?(item)
    self.want_items.include?(item)
  end

  def have(item)
    self.haves.find_or_create_by(item_id: item.id)
  end

  def unhave(item)
    have = self.haves.find_by(item_id: item.id)
    have.destroy if have
  end

  def have?(item)
    self.have_items.include?(item)
  end
end